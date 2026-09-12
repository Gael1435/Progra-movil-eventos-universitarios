import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CampusEventosApp());
}

class CampusEventosApp extends StatefulWidget {
  const CampusEventosApp({super.key});

  @override
  State<CampusEventosApp> createState() => _CampusEventosAppState();
}

class _CampusEventosAppState extends State<CampusEventosApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Eventos',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(
        onThemeChanged: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
