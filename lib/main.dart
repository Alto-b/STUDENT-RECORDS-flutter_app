import 'package:flutter/material.dart';
import 'package:student_records/Pages/homepage.dart';
//import 'package:student_records/Pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Records',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 9, 9, 9)),

        useMaterial3: true,
      ),
      home: Homepage()
    );
  }
}
