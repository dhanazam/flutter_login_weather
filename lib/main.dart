import 'package:flutter/material.dart';
import 'package:login_weather_flutter/login/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Page',
      home: LoginPage()
    );
  }
}