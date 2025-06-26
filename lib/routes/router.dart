import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snapcarbon/features/calculator_carbon/calculator_screen.dart';
import 'package:snapcarbon/features/camera/camera_screen.dart';
import 'package:snapcarbon/features/challenge/challenge_screen.dart';
import 'package:snapcarbon/features/history/history_screen.dart';
import 'package:snapcarbon/features/home/home_screen.dart';
import 'package:snapcarbon/features/main/main_screen.dart';
import 'package:snapcarbon/features/offset_carbon/offset_screen.dart';
import 'package:snapcarbon/features/profile/profile.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: MainRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(
          page: HomeRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: ChallengeRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: CameraRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: HistoryRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: ProfileRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ],
    ),
    CustomRoute(
      page: CalculatorRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: OffsetRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
