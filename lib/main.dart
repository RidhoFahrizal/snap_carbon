import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
// Make sure the file 'app_theme.dart' exists in the 'theme' folder and contains the 'AppTheme' class with a static 'getTheme' method.

void main() {
  runApp(const SnapCarbonApp());
}

class SnapCarbonApp extends StatelessWidget {
  const SnapCarbonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapCarbon Theme Demo',
      theme: AppTheme.getTheme(context), // Use the AppTheme class to get the theme
      home: const ThemeDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ThemeDemoScreen extends StatelessWidget {
  const ThemeDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapCarbon AppTheme Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display typography
              Text('Display Large', style: theme.textTheme.displayLarge),
              Text('Display Medium', style: theme.textTheme.displayMedium),
              Text('Display Small', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text('Headline Large', style: theme.textTheme.headlineLarge),
              Text('Headline Medium', style: theme.textTheme.headlineMedium),
              Text('Headline Small', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text('Body Large', style: theme.textTheme.bodyLarge),
              Text('Body Medium', style: theme.textTheme.bodyMedium),
              Text('Body Small', style: theme.textTheme.bodySmall),
              const SizedBox(height: 12),
              Text('Label Large', style: theme.textTheme.labelLarge),
              Text('Label Medium', style: theme.textTheme.labelMedium),
              Text('Label Small', style: theme.textTheme.labelSmall),
              const SizedBox(height: 24),

              // Buttons
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated Button'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined Button'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text('Text Button'),
              ),
              const SizedBox(height: 24),

              // Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card Title', style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        'This is a sample card using your AppTheme. You can customize cards, buttons, inputs, etc. according to your needs.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Input Label',
                  hintText: 'Type here...',
                ),
              ),
              const SizedBox(height: 24),

              // Chip
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Green Chip')),
                  Chip(label: Text('Selected'), backgroundColor: theme.colorScheme.secondary),
                  Chip(label: Text('Disabled'), backgroundColor: theme.disabledColor),
                ],
              ),
              const SizedBox(height: 24),

              // FAB
              Center(
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Navigation preview
              BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.eco),
                    label: 'Green',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}