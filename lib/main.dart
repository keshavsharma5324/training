import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trainings/screens/training_detail.dart';
import 'package:trainings/screens/trainings_dashboard.dart';
import 'package:trainings/models/trainings_model.dart';

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