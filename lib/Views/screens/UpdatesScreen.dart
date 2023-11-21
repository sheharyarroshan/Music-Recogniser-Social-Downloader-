import 'package:flutter/material.dart';
import 'package:nextmusic/utils/contants.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300.0,
              width: 365.0,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.10),
                      offset: Offset(0, 0),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 0.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: []),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
