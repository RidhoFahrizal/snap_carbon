import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow none = BoxShadow(
    color: Colors.transparent,
    offset: Offset(0, 0),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow sm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow md = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(0, 4),
    blurRadius: 6,
    spreadRadius: -1,
  );

  static const BoxShadow lg = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(0, 10),
    blurRadius: 15,
    spreadRadius: -3,
  );

  static const BoxShadow xl = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(0, 20),
    blurRadius: 25,
    spreadRadius: -5,
  );
}