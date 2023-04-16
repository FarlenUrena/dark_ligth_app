import 'package:app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider({required this.isLightTheme});

  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.navColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  //use to toggle the theme
  toggleThemeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isLightTheme) {
      sharedPreferences.setBool(SPref.isLight, false);
      isLightTheme = !isLightTheme;
      notifyListeners();
    } else {
      sharedPreferences.setBool(SPref.isLight, true);
      isLightTheme = !isLightTheme;
      notifyListeners();
    }
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
        brightness: isLightTheme ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor:
            isLightTheme ? AppColors.lightRed : AppColors.black,
        textTheme: TextTheme(
            headlineLarge: GoogleFonts.stickNoBills(
              fontSize: 70,
              fontWeight: FontWeight.w600,
              color: isLightTheme ? AppColors.black : AppColors.darkRed,
            ),
            headlineMedium: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.w500,
              color: isLightTheme ? AppColors.black : AppColors.darkRed,
            )));
  }

  ThemeMode themeMode() {
    return ThemeMode(
      gradientColors: isLightTheme
          ? [AppColors.lightRed, AppColors.darkRed]
          : [AppColors.black, AppColors.black],
      switchColor: isLightTheme ? AppColors.black : AppColors.darkRed,
      thumbColor: isLightTheme ? AppColors.darkRed : AppColors.black,
      switchBgColor: isLightTheme
          ? AppColors.black.withOpacity(.1)
          : AppColors.grey.withOpacity(.3),
    );
  }
}

class ThemeMode {
  List<Color>? gradientColors;
  Color? switchColor;
  Color? thumbColor;
  Color? switchBgColor;

  ThemeMode(
      {this.gradientColors,
      this.switchColor,
      this.thumbColor,
      this.switchBgColor});
}
