import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snapcarbon/theme/typography.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text('Custom App Bar', style: AppTypography.bodyLarge),
            ),
            Center(
              child: Text(
                'Welcome to the Home Screen',
                style: AppTypography.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
