import 'package:flutter/material.dart';
import 'package:trainings/screens/trainings_dashboard.dart';

void main() {
  runApp(const MyApp());
}

enum Filters { location, training, trainer }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TrainingsDashboard(),
    );
  }
}