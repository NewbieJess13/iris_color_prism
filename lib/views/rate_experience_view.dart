import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:iris_color_prism/models/emotion.dart';
import 'package:iris_color_prism/views/overview_view.dart';
import 'package:iris_color_prism/widgets/background.dart';

class RateExperienceView extends StatefulWidget {
  const RateExperienceView({
    super.key,
    required this.firstEmotionLevel,
    this.secondEmotionLevel,
    required this.firstEmotion,
    this.secondEmotion,
  });
  final int firstEmotionLevel;
  final int? secondEmotionLevel;
  final Emotion firstEmotion;
  final Emotion? secondEmotion;

  @override
  State<RateExperienceView> createState() => _RateExperienceViewState();
}

class _RateExperienceViewState extends State<RateExperienceView> {
  double userRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
          foregroundChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How would you rate your overall experience of using the app?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedRatingStars(
            initialRating: userRating,
            minRating: 0.0,
            maxRating: 5.0,
            filledColor: Colors.amber,
            emptyColor: Colors.grey,
            filledIcon: Icons.star,
            halfFilledIcon: Icons.star_half,
            emptyIcon: Icons.star_border,
            onChanged: (double rating) {
              // Handle the rating change here
              setState(() {
                userRating = rating;
              });
            },
            displayRatingValue: true,
            interactiveTooltips: true,
            customFilledIcon: Icons.star,
            customHalfFilledIcon: Icons.star_half,
            customEmptyIcon: Icons.star_border,
            starSize: 50.0,
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,
            readOnly: false,
          )
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OverviewView(
                        firstEmotion: widget.firstEmotion,
                        firstEmotionLevel: widget.firstEmotionLevel,
                        secondEmotion: widget.secondEmotion,
                        secondEmotionLevel: widget.secondEmotionLevel,
                        rating: userRating,
                      )));
            },
            child: Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            )),
      ),
    );
  }
}
