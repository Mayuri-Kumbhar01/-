import 'package:flutter/material.dart';
import 'splash_screen.dart';


void main() {
  runApp(ArthGuruApp());
}

class ArthGuruApp extends StatelessWidget {
  const ArthGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A₹thaगुरू',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0xFFFFF3E0),
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}git commit -m "Initial commit from Google IDX"
