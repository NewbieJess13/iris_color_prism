import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iris_color_prism/data/assets.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/emotions_view.dart';
import 'package:iris_color_prism/views/rate_experience_view.dart';
import 'package:multi_video_player/multi_video_player.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VidView extends StatefulWidget {
  const VidView(
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
  State<VidView> createState() => _VidViewState();
}

class _VidViewState extends State<VidView> {
  late List<String> videos;
  late AssetsSource _assetsSource;
  late PreloadPageController _videoPageController;
  late VideoPlayerOptions _videoPlayerOptions;
  int displayCount = 1;
  @override
  void initState() {
    _assetsSource = AssetsSource();
    getVideos();
    _videoPageController = PreloadPageController();
    _videoPlayerOptions = VideoPlayerOptions();

    super.initState();
  }

  @override
  void dispose() {
    videos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MultiVideoPlayer.asset(
            videoSourceList: videos,
            height: double.infinity,
            width: double.infinity,
            pageController: _videoPageController,
            videoPlayerOptions: _videoPlayerOptions,
            preloadPagesCount: 3,
            scrollDirection: Axis.horizontal,
            showControlsOverlay: false,
            showVideoProgressIndicator: false,
            onPageChanged: (videoPlayerController, page) {
              if (page == 20) {
                videoPlayerController!.addListener(() async {
                  if (videoPlayerController.value.isCompleted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmotionsPage(
                              round: 2,
                            )));
                  }
                });
              }
            },
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(.5)),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 5),
                child: IconButton(
                    onPressed: () async {
                      await _videoPageController.previousPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.ease);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: Colors.white54,
                    )),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(.5)),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () async {
                      await _videoPageController.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.ease);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                      color: Colors.white54,
                    )),
              ))
        ],
      ),
    );
  }

  void getVideos() {
    final List<String> selectedVideos = [];
    List<String> videoAssets = [];
    switch (widget.color) {
      case "BLUE":
        {
          videoAssets.addAll(_assetsSource.blueAssets['videos']);
        }
        break;
      case "VIOLET":
        {
          videoAssets.addAll(_assetsSource.violetAssets['videos']);
        }
        break;
      case "GREEN":
        {
          videoAssets.addAll(_assetsSource.greenAssets['videos']);
        }
        break;

      case "PINK":
        {
          videoAssets.addAll(_assetsSource.pinkAssets['videos']);
        }
        break;
      case "ORANGE":
        {
          videoAssets.addAll(_assetsSource.orangeAssets['videos']);
        }
        break;
      case "YELLOW":
        {
          videoAssets.addAll(_assetsSource.yellowAssets['videos']);
        }
        break;
    }
    for (int i = 0; i <= 20; i++) {
      final String video = (videoAssets..shuffle()).first;
      selectedVideos.add('assets/$video');
    }
    setState(() {
      videos = selectedVideos;
    });
  }
}
