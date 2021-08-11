import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WallpaperHub',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}

