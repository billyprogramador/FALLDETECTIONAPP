import 'package:falldetectionapp/Pages/initpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        scaffoldBackgroundColor: Colors.white
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('FALL DETECTION APP')),
        body: const InitPage()
      )
    );
  }
}