import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snapcarbon/theme/typography.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                'Welcome to the History Screen',
                style: AppTypography.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
