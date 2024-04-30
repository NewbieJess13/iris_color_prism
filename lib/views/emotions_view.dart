import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iris_color_prism/data/emotions.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/emotion_scale_view.dart';
import 'package:iris_color_prism/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmotionsPage extends StatefulWidget {
  const EmotionsPage({super.key, this.round = 0});
  final int round;

  @override
  State<EmotionsPage> createState() => _EmotionsPageState();
}

class _EmotionsPageState extends State<EmotionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        foregroundChild: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                widget.round == 2
                    ? "After watching the pictures and videos, how are you feeling right now?"
                    : 'How are you feeling right now?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: AnimationLimiter(
                    child: GridView.builder(
                        itemCount: emotions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 50,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final Emotion emotion = emotions[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: 2,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: EmotionCard(
                                  emotion: emotion,
                                  onTap: () async {
                                    // Obtain shared preferences.
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (widget.round == 2) {
                                      await prefs.setString(
                                          'second_emotion', emotion.title);
                                    } else {
                                      await prefs.setString(
                                          'first_emotion', emotion.title);
                                    }
                                    final String color = (emotion.emotionColors
                                          ..shuffle())
                                        .first;

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmotionScaleView(
                                                  firstEmotion: emotion,
                                                  secondEmotion:
                                                      widget.round == 2
                                                          ? emotion
                                                          : null,
                                                  color: color,
                                                  round: widget.round,
                                                )));
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionCard extends StatelessWidget {
  const EmotionCard({super.key, required this.emotion, required this.onTap});
  final Emotion emotion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 250,
            width: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  emotion.color.shade900,
                  emotion.color.shade500,
                  emotion.color.shade400,
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.bottomCenter,
            child: Text(
              emotion.title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          Positioned(
              top: -50,
              child: Image.asset(
                emotion.imagePath,
                height: 180,
                width: 100,
                fit: BoxFit.contain,
              ))
        ],
      ),
    );
  }
}
