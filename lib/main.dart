import 'package:flutter/material.dart';
import 'package:riafy_test/MainScreen.dart';
void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

