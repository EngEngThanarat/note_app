import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  )
);

// dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade300,
  )
);