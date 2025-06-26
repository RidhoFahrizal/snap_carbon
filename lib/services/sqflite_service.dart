import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; // Required for 'join' method

class SqliteService {
  static const String _databaseName = 'snapcarbon.db';
  static const int _version = 1;

  // Table Names
  static const String _tableUsers = 'users';
  static const String _tableCarbonFootprintEntries = 'carbon_footprint_entries';
  static const String _tableOffsetProjects = 'offset_projects';
  static const String _tableCarbonOffsetActivities = 'carbon_offset_activities';
  static const String _tableChallenges = 'challenges';
  static const String _tableUserChallengeProgress = 'user_challenge_progress';
  static const String _tableChallengeOffsetRelations =
      'challenge_offset_relations';

  Database? _database; // Use nullable type for late initialization

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    final db = await openDatabase(
      path,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
      onConfigure: (Database database) async {
        await database.execute(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key support
      },
    );
    return db;
  }

  Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableUsers(
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          avatar_url TEXT,
          total_xp INTEGER DEFAULT 0,
          total_carbon_emitted_kg REAL DEFAULT 0.0,
          total_carbon_offset_kg REAL DEFAULT 0.0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableCarbonFootprintEntries(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          user_id TEXT NOT NULL,
          source_type TEXT NOT NULL,
          co2_emitted_kg REAL NOT NULL,
          description TEXT,
          details_json TEXT,
          entry_date TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES $_tableUsers(id) ON DELETE CASCADE
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableOffsetProjects(
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          description TEXT,
          estimated_offset_kg_per_unit REAL,
          cost_per_unit REAL,
          location TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableCarbonOffsetActivities(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          user_id TEXT NOT NULL,
          project_name TEXT NOT NULL,
          offset_project_id TEXT,
          co2_offset_kg REAL NOT NULL,
          contribution_amount REAL,
          offset_date TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES $_tableUsers(id) ON DELETE CASCADE,
          FOREIGN KEY (offset_project_id) REFERENCES $_tableOffsetProjects(id) ON DELETE SET NULL
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableChallenges(
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          description TEXT,
          start_date TEXT NOT NULL,
          end_date TEXT NOT NULL,
          xp_reward INTEGER DEFAULT 0,
          estimated_carbon_reduction_kg REAL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableUserChallengeProgress(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          user_id TEXT NOT NULL,
          challenge_id TEXT NOT NULL,
          current_progress_value REAL DEFAULT 0.0,
          target_value REAL NOT NULL,
          is_completed INTEGER DEFAULT 0,
          completion_date TEXT,
          xp_awarded INTEGER DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
          UNIQUE(user_id, challenge_id),
          FOREIGN KEY (user_id) REFERENCES $_tableUsers(id) ON DELETE CASCADE,
          FOREIGN KEY (challenge_id) REFERENCES $_tableChallenges(id) ON DELETE CASCADE
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableChallengeOffsetRelations(
          challenge_id TEXT NOT NULL,
          offset_project_id TEXT NOT NULL,
          PRIMARY KEY (challenge_id, offset_project_id),
          FOREIGN KEY (challenge_id) REFERENCES $_tableChallenges(id) ON DELETE CASCADE,
          FOREIGN KEY (offset_project_id) REFERENCES $_tableOffsetProjects(id) ON DELETE CASCADE
      )
    """);
  }

  // --- CRUD Operations ---

  // --- Users Table ---
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      _tableUsers,
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableUsers,
      where: 'id = ?',
      whereArgs: [userId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> updateUser(String userId, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      _tableUsers,
      {...user, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Note: Actual user deletion might be handled via Google, or a soft-delete strategy
  Future<int> deleteUser(String userId) async {
    final db = await database;
    return await db.delete(_tableUsers, where: 'id = ?', whereArgs: [userId]);
  }

  // --- CarbonFootprintEntries Table ---
  Future<int> insertCarbonFootprintEntry(Map<String, dynamic> entry) async {
    final db = await database;
    return await db.insert(_tableCarbonFootprintEntries, entry);
  }

  Future<List<Map<String, dynamic>>> getCarbonFootprintEntriesByUserId(
    String userId,
  ) async {
    final db = await database;
    return await db.query(
      _tableCarbonFootprintEntries,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'entry_date DESC, created_at DESC',
    );
  }

  Future<Map<String, dynamic>?> getCarbonFootprintEntryById(int entryId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableCarbonFootprintEntries,
      where: 'id = ?',
      whereArgs: [entryId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> updateCarbonFootprintEntry(
    int entryId,
    Map<String, dynamic> entry,
  ) async {
    final db = await database;
    return await db.update(
      _tableCarbonFootprintEntries,
      {...entry, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [entryId],
    );
  }

  Future<int> deleteCarbonFootprintEntry(int entryId) async {
    final db = await database;
    return await db.delete(
      _tableCarbonFootprintEntries,
      where: 'id = ?',
      whereArgs: [entryId],
    );
  }

  Future<double> getDailyCarbonSummary(String userId, String date) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(co2_emitted_kg) as total FROM $_tableCarbonFootprintEntries WHERE user_id = ? AND SUBSTR(entry_date, 1, 10) = ?',
      [userId, date], // date in YYYY-MM-DD format
    );
    return (result.first['total'] as double?) ?? 0.0;
  }

  Future<double> getWeeklyCarbonAverage(String userId, String endDate) async {
    final db = await database;
    // Calculate the start date for the last 7 days including the endDate
    final DateTime end = DateTime.parse(endDate);
    final DateTime start = end.subtract(Duration(days: 6)); // 7 days total

    final result = await db.rawQuery(
      'SELECT AVG(co2_emitted_kg) as avg_total FROM $_tableCarbonFootprintEntries WHERE user_id = ? AND entry_date BETWEEN ? AND ?',
      [
        userId,
        start.toIso8601String().substring(0, 10),
        end.toIso8601String().substring(0, 10),
      ], // Compare just dates
    );
    return (result.first['avg_total'] as double?) ?? 0.0;
  }

  // --- OffsetProjects Table (for admin/seeding) ---
  Future<int> insertOffsetProject(Map<String, dynamic> project) async {
    final db = await database;
    return await db.insert(
      _tableOffsetProjects,
      project,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getOffsetProjectById(String projectId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableOffsetProjects,
      where: 'id = ?',
      whereArgs: [projectId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllOffsetProjects() async {
    final db = await database;
    return await db.query(_tableOffsetProjects, orderBy: 'name ASC');
  }

  // --- CarbonOffsetActivities Table ---
  Future<int> insertCarbonOffsetActivity(Map<String, dynamic> activity) async {
    final db = await database;
    return await db.insert(_tableCarbonOffsetActivities, activity);
  }

  Future<List<Map<String, dynamic>>> getCarbonOffsetActivitiesByUserId(
    String userId,
  ) async {
    final db = await database;
    return await db.query(
      _tableCarbonOffsetActivities,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'offset_date DESC, created_at DESC',
    );
  }

  Future<Map<String, dynamic>?> getCarbonOffsetActivityById(
    int activityId,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableCarbonOffsetActivities,
      where: 'id = ?',
      whereArgs: [activityId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> getLatestCarbonOffsetActivities(
    String userId,
    int limit,
  ) async {
    final db = await database;
    return await db.query(
      _tableCarbonOffsetActivities,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'offset_date DESC, created_at DESC',
      limit: limit,
    );
  }

  // --- Challenges Table (for admin/seeding) ---
  Future<int> insertChallenge(Map<String, dynamic> challenge) async {
    final db = await database;
    return await db.insert(
      _tableChallenges,
      challenge,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getChallengeById(String challengeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableChallenges,
      where: 'id = ?',
      whereArgs: [challengeId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllActiveChallenges(
    String currentDate,
  ) async {
    final db = await database;
    return await db.query(
      _tableChallenges,
      where: 'start_date <= ? AND end_date >= ?',
      whereArgs: [currentDate, currentDate], // currentDate in YYYY-MM-DD format
      orderBy: 'end_date ASC',
    );
  }

  // --- UserChallengeProgress Table ---
  Future<int> insertUserChallengeProgress(Map<String, dynamic> progress) async {
    final db = await database;
    return await db.insert(
      _tableUserChallengeProgress,
      progress,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserChallengeProgress(
    String userId,
    String challengeId,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableUserChallengeProgress,
      where: 'user_id = ? AND challenge_id = ?',
      whereArgs: [userId, challengeId],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> updateUserChallengeProgress(
    String userId,
    String challengeId,
    Map<String, dynamic> progress,
  ) async {
    final db = await database;
    return await db.update(
      _tableUserChallengeProgress,
      {...progress, 'updated_at': DateTime.now().toIso8601String()},
      where: 'user_id = ? AND challenge_id = ?',
      whereArgs: [userId, challengeId],
    );
  }

  Future<List<Map<String, dynamic>>> getTopUserXp(int limit) async {
    final db = await database;
    return await db.query(_tableUsers, orderBy: 'total_xp DESC', limit: limit);
  }

  Future<int> getUserRank(String userId) async {
    final db = await database;
    // This query is less efficient for very large tables but common for SQLite.
    // It returns the rank based on total_xp.
    final result = await db.rawQuery(
      'SELECT COUNT(*) + 1 as rank FROM $_tableUsers WHERE total_xp > (SELECT total_xp FROM $_tableUsers WHERE id = ?)',
      [userId],
    );
    return (result.first['rank'] as int?) ??
        1; // Default to 1 if no user or highest XP
  }

  // --- ChallengeOffsetRelations Table ---
  Future<int> insertChallengeOffsetRelation(
    Map<String, dynamic> relation,
  ) async {
    final db = await database;
    return await db.insert(
      _tableChallengeOffsetRelations,
      relation,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getOffsetProjectsForChallenge(
    String challengeId,
  ) async {
    final db = await database;
    return await db.rawQuery(
      '''
      SELECT op.*
      FROM $_tableOffsetProjects op
      INNER JOIN $_tableChallengeOffsetRelations cor ON op.id = cor.offset_project_id
      WHERE cor.challenge_id = ?
    ''',
      [challengeId],
    );
  }

  Future<List<Map<String, dynamic>>> getChallengesForOffsetProject(
    String offsetProjectId,
  ) async {
    final db = await database;
    return await db.rawQuery(
      '''
      SELECT c.*
      FROM $_tableChallenges c
      INNER JOIN $_tableChallengeOffsetRelations cor ON c.id = cor.challenge_id
      WHERE cor.offset_project_id = ?
    ''',
      [offsetProjectId],
    );
  }
}
