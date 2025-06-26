import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'radius.dart';
import 'shadow.dart';
import 'spacing.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.green400,           // Main green (for buttons, highlights)
        onPrimary: AppColors.neutral50,        // Text/icons on primary green
        secondary: AppColors.green200,         // Accent green (for chips, accents)
        onSecondary: AppColors.neutral900,
        background: AppColors.neutral50,       // Main background
        onBackground: AppColors.neutral900,    // Text/icons on background
        surface: AppColors.neutral100,         // Cards, surfaces
        onSurface: AppColors.neutral900,
        error: Color(0xFFFF6D6D),              // Custom error (soft red)
        onError: AppColors.neutral50,
      ),
      scaffoldBackgroundColor: AppColors.neutral50,
      fontFamily: AppTypography.fontFamily,
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headingLarge,
        headlineMedium: AppTypography.headingMedium,
        headlineSmall: AppTypography.headingSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green400,
          foregroundColor: AppColors.neutral50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          shadowColor: AppShadows.md.color,
          elevation: AppShadows.md.blurRadius,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.green400,
          side: const BorderSide(color: AppColors.green400, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.green400,
          textStyle: AppTypography.labelMedium,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.neutral100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
        elevation: AppShadows.sm.blurRadius,
        shadowColor: AppShadows.sm.color,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral100,
        contentPadding: const EdgeInsets.all(AppSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(
            color: AppColors.neutral300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(
            color: AppColors.neutral300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(
            color: AppColors.green400,
            width: 2,
          ),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.neutral400,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.green400,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.green50,
        selectedColor: AppColors.green200,
        disabledColor: AppColors.neutral200,
        secondarySelectedColor: AppColors.green400,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.sm,
        ),
        labelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.green500,
        ),
        secondaryLabelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.neutral50,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.neutral100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        titleTextStyle: AppTypography.headingMedium,
        contentTextStyle: AppTypography.bodyMedium,
      ),
      dividerColor: AppColors.neutral200,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.neutral50,
        elevation: 0,
        foregroundColor: AppColors.neutral900,
        titleTextStyle: AppTypography.headingMedium.copyWith(
          color: AppColors.neutral900,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.neutral900,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.green400,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.green400,
        foregroundColor: AppColors.neutral50,
        elevation: AppShadows.md.blurRadius,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.neutral100,
        selectedItemColor: AppColors.green400,
        unselectedItemColor: AppColors.neutral400,
        selectedLabelStyle: AppTypography.labelMedium,
        unselectedLabelStyle: AppTypography.labelSmall,
        showUnselectedLabels: true,
      ),
      // Use custom shadow for cards/surfaces if needed
      shadowColor: AppShadows.sm.color,
      // Add other theming as needed...
    );
  }
}