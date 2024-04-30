import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iris_color_prism/data/assets.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/vid_view.dart';

class PicsView extends StatefulWidget {
  const PicsView(
      {super.key,
      required this.color,
      this.round = 0,
      required this.firstEmotionLevel,
      this.secondEmotionLevel,
      required this.firstEmotion,
      this.secondEmotion});
  final int round;
  final String color;
  final int firstEmotionLevel;
  final int? secondEmotionLevel;
  final Emotion firstEmotion;
  final Emotion? secondEmotion;
  @override
  State<PicsView> createState() => _PicsViewState();
}

class _PicsViewState extends State<PicsView> {
  late List<String> images;
  final List<String> selectedImages = [];
  late AssetsSource _assetsSource;

  late final Timer timer;
  int _index = 0;
  int displayCount = 1;
  @override
  void initState() {
    _assetsSource = AssetsSource();
    getImages();
    timer = Timer.periodic(Duration(seconds: 6), (timer) {
      setState(() {
        _index++;
        displayCount++;
      });
      if (displayCount == 10) {
        timer.cancel();
        Future.delayed(Duration(seconds: 6), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VidView(
                    color: widget.color,
                    round: widget.round,
                    firstEmotionLevel: widget.firstEmotionLevel,
                    firstEmotion: widget.firstEmotion,
                    secondEmotion: widget.secondEmotion,
                    secondEmotionLevel: widget.secondEmotionLevel,
                  )));
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    images.clear();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 2000),
        switchInCurve: Curves.linear,
        switchOutCurve: Curves.linear,
        child: Image.asset(
          'assets/${images[_index % images.length]}',
          key: UniqueKey(),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  void getImages() {
    List<String> imageAssets = [];
    switch (widget.color) {
      case "BLUE":
        {
          imageAssets = _assetsSource.blueAssets['images'];
        }
        break;
      case "VIOLET":
        {
          imageAssets = _assetsSource.violetAssets['images'];
        }
        break;
      case "GREEN":
        {
          imageAssets = _assetsSource.greenAssets['images'];
        }
        break;
      case "PINK":
        {
          imageAssets = _assetsSource.pinkAssets['images'];
        }
        break;
      case "ORANGE":
        {
          imageAssets = _assetsSource.orangeAssets['images'];
        }
        break;
      case "YELLOW":
        {
          imageAssets = _assetsSource.yellowAssets['images'];
        }
        break;
    }
    for (int i = 0; i <= 10; i++) {
      final String image = (imageAssets..shuffle()).first;
      selectedImages.add(image);
    }
    setState(() {
      images = selectedImages;
    });
  }
}
