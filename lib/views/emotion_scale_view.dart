import 'package:flutter/material.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/rate_experience_view.dart';
import 'package:iris_color_prism/views/pics_view.dart';
import 'package:iris_color_prism/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmotionScaleView extends StatefulWidget {
  const EmotionScaleView(
      {super.key,
      required this.firstEmotion,
      required this.color,
      this.round = 0,
      this.secondEmotion});
  final int round;
  final Emotion? secondEmotion;
  final Emotion firstEmotion;
  final String color;

  @override
  State<EmotionScaleView> createState() => _EmotionScaleViewState();
}

class _EmotionScaleViewState extends State<EmotionScaleView> {
  int emotionLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
          foregroundChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'On a scale of 1 to 3 how ${widget.round == 2 ? widget.secondEmotion!.title : widget.firstEmotion.title} are you?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          RadioListTile<int>(
              value: 1,
              groupValue: emotionLevel,
              title: Text(
                "1 <Slightly>",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    emotionLevel = val;
                  });
                }
              }),
          RadioListTile<int>(
              value: 2,
              groupValue: emotionLevel,
              title: Text(
                "2 <Moderately>",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    emotionLevel = val;
                  });
                }
              }),
          RadioListTile<int>(
              value: 3,
              groupValue: emotionLevel,
              title: Text(
                "3 <Extremely>",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    emotionLevel = val;
                  });
                }
              }),
        ],
      )),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              print('round:${widget.round}');
              // return;
              if (widget.round == 2) {
                await prefs.setInt('second_emotion_level', emotionLevel);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RateExperienceView(
                          firstEmotion: widget.firstEmotion,
                          firstEmotionLevel: emotionLevel,
                        )));
              } else {
                await prefs.setInt('first_emotion_level', emotionLevel);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PicsView(
                          color: widget.color,
                          round: widget.round,
                          firstEmotion: widget.firstEmotion,
                          firstEmotionLevel: emotionLevel,
                          secondEmotionLevel:
                              widget.round == 2 ? emotionLevel : null,
                        )));
              }
            },
            child: Text(
              "Proceed",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            )),
      ),
    );
  }
}
