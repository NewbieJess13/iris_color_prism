import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.foregroundChild});
  final Widget foregroundChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -130,
            left: -130,
            child: Image.asset(
              'assets/violet.png',
              height: 500,
              width: 500,
            )),
        Positioned(
            left: 0,
            bottom: 200,
            child: Image.asset(
              'assets/orange.png',
              height: 350,
              width: 350,
            )),
        Positioned(
            bottom: -130,
            right: -130,
            child: Image.asset(
              'assets/pink.png',
              height: 400,
              width: 400,
            )),
        foregroundChild
      ],
    );
  }
}
