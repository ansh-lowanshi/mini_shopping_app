import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_e_commerce/home_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-commerce App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlayfairDisplay',
      ),
      home: HomePage(),
    );
  }
}
