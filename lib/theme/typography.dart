import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static const String fontFamily = 'Montserrat';


  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font sizes
  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double md = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xl2 = 24.0;
  static const double xl3 = 30.0;
  static const double xl4 = 36.0;
  static const double xl5 = 48.0;

  // Line heights
  static const double lineHeightTight = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  // Text styles
  static TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl5,
    fontWeight: bold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl4,
    fontWeight: bold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl3,
    fontWeight: bold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get headingLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl2,
    fontWeight: semiBold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get headingMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl,
    fontWeight: semiBold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get headingSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: lg,
    fontWeight: semiBold,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: md,
    fontWeight: regular,
    color: AppColors.neutral800,
    height: lineHeightNormal,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: sm,
    fontWeight: regular,
    color: AppColors.neutral800,
    height: lineHeightNormal,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: xs,
    fontWeight: regular,
    color: AppColors.neutral700,
    height: lineHeightNormal,
  );

  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: md,
    fontWeight: medium,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: sm,
    fontWeight: medium,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: xs,
    fontWeight: medium,
    color: AppColors.neutral900,
    height: lineHeightTight,
  );
}