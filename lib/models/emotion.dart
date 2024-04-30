import 'package:flutter/material.dart';

class Emotion {
  final String title;
  final String imagePath;
  final MaterialColor color;
  final List<String> emotionColors;

  Emotion(
      {required this.title,
      required this.imagePath,
      required this.color,
      required this.emotionColors});
}
