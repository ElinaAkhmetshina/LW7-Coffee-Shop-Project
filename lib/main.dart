import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          primary: const Color(0xFF613A28),
        ),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}