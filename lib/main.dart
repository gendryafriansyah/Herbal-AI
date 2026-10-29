import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/main_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HerbalAI',
      theme: AppTheme.themeData,
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
