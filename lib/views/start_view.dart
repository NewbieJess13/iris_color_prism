import 'package:flutter/material.dart';
import 'package:iris_color_prism/views/emotions_view.dart';
import 'package:iris_color_prism/widgets/background.dart';

class StartView extends StatefulWidget {
  const StartView({super.key, this.round});
  final int? round;
  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  int incrementRound = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
          foregroundChild: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Manage your emotions',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              "Iris' Color Prism",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade400),
                onPressed: () {
                  int existingRound = widget.round ?? 0;
                  final newRound = widget.round != null
                      ? existingRound += 1
                      : incrementRound += 1;

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmotionsPage(
                            round: newRound,
                          )));
                },
                child: Text('Start'))
          ],
        ),
      )),
    );
  }
}
