import 'package:flutter/material.dart';
import 'package:password_generator_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Generator',
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
