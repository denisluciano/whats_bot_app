// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/desafios_page.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tá Pago Admin',
      theme: ThemeData(primarySwatch: Colors.green),
      home: DesafiosPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
