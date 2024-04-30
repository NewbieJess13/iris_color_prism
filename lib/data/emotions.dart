import 'package:flutter/material.dart';
import 'package:iris_color_prism/models/emotion.dart';

final List<Emotion> emotions = [
  Emotion(
      title: 'Joyful',
      imagePath: 'assets/joy.webp',
      color: Colors.yellow,
      emotionColors: ['PINK', 'ORANGE', 'BLUE']),
  Emotion(
      title: 'Sad',
      imagePath: 'assets/sadness.webp',
      color: Colors.blue,
      emotionColors: ['ORANGE', 'YELLOW', 'PINK']),
  Emotion(
      title: 'Scared',
      imagePath: 'assets/fear.webp',
      color: Colors.purple,
      emotionColors: ['GREEN', 'BLUE', 'YELLOW']),
  Emotion(
      title: 'Anxious',
      imagePath: 'assets/anxiety.webp',
      color: Colors.orange,
      emotionColors: ['BLUE', 'VIOLET', 'GREEN']),
  Emotion(
      title: 'Angry',
      imagePath: 'assets/anger.webp',
      color: Colors.red,
      emotionColors: ['GREEN', 'VIOLET', 'BLUE']),
];
