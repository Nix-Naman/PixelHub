import 'package:flutter/material.dart';

class Themes {
  ThemeData light = ThemeData(
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
      ));
  ThemeData dark = ThemeData(
    canvasColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
    ),
  );
}
