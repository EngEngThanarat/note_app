import 'package:flutter/material.dart';
import 'package:note_app_nosql/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  // initial theme light mode
  ThemeData _themeData = lightMode;

  // getter method to access theme other part of code
  ThemeData get themeData => _themeData;

  //  getter method to see if we are dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  // setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle to switch mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode; 
    } else {
      themeData = lightMode;
    }
  }
}