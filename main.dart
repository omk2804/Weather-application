import 'package:flutter/material.dart';
import 'package:weather_app/weather_material_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherMaterialApp(),
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
