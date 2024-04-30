import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/start_view.dart';
import 'package:iris_color_prism/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({
    super.key,
    required this.rating,
    required this.firstEmotionLevel,
    this.secondEmotionLevel,
    required this.firstEmotion,
    this.secondEmotion,
  });
  final double rating;
  final int firstEmotionLevel;
  final int? secondEmotionLevel;
  final Emotion firstEmotion;
  final Emotion? secondEmotion;
  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  String? secondEmotion;
  int? secondEmotionIntensity;
  String? firstEmotion;
  int? firstEmotionIntensity;

  @override
  void initState() {
    initEmotion();
    super.initState();
  }

  initEmotion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      secondEmotion = prefs.getString('second_emotion');
      secondEmotionIntensity = prefs.getInt('second_emotion_level');
      firstEmotion = prefs.getString('first_emotion');
      firstEmotionIntensity = prefs.getInt('first_emotion_level');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AppBackground(
          foregroundChild: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Result Overview',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(text: "Emotion before: ", children: [
                  TextSpan(
                      text: firstEmotion,
                      style:
                          TextStyle(color: Colors.amber.shade400, fontSize: 25))
                ]),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text.rich(
                TextSpan(text: "Intensity before: ", children: [
                  TextSpan(
                      text: firstEmotionIntensity.toString(),
                      style: TextStyle(fontSize: 25))
                ]),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text.rich(
                TextSpan(text: "Emotion after: ", children: [
                  TextSpan(
                      text: secondEmotion,
                      style:
                          TextStyle(color: Colors.blue.shade400, fontSize: 25))
                ]),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text.rich(
                TextSpan(text: "Intensity after: ", children: [
                  TextSpan(
                      text: secondEmotionIntensity.toString(),
                      style: TextStyle(fontSize: 25))
                ]),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text.rich(
                TextSpan(text: "User Rating: ", children: [
                  TextSpan(
                      text: widget.rating.toString(),
                      style: TextStyle(fontSize: 25))
                ]),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              AnimatedRatingStars(
                initialRating: widget.rating,
                minRating: 0.0,
                maxRating: 5.0,
                filledColor: Colors.amber,
                emptyColor: Colors.grey,
                filledIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                emptyIcon: Icons.star_border,
                readOnly: true,
                displayRatingValue: true,
                interactiveTooltips: true,
                customFilledIcon: Icons.star,
                customHalfFilledIcon: Icons.star_half,
                customEmptyIcon: Icons.star_border,
                starSize: 15.0,
                animationDuration: Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                onChanged: (p0) {},
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => StartView(
                            round: 0,
                          )),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            )),
      ),
    );
  }
}
