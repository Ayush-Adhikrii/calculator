import 'package:flutter/material.dart';
import 'view/calculator_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/calculator',
      debugShowCheckedModeBanner: false,
      routes: {
        '/calculator': (context) => const CalculatorView(),
      },
    );
  }
}
