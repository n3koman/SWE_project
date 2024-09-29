import 'package:flutter/material.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Market',
      theme: ThemeData(primarySwatch: Colors.green),
      home: IntroScreen(),
    );
  }
}
