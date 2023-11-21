import 'package:blinking_text/blinking_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

var listenText = const BlinkText(
  'Listening for music',
  style: TextStyle(
    fontSize: 26.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  ),
  endColor: Color(0xFF042442),
  times: 9223372036854775807,
  duration: Duration(seconds: 1),
);

var CancelText = const BlinkText(
  'Double Tap to cancel',
  style: TextStyle(fontSize: 17.0, color: Colors.white),
  endColor: Color(0xFF042442),
  times: 9223372036854775807,
  duration: Duration(seconds: 1),
);

var TapListenText = const Text(
  'Tap to Listen Music',
  style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);

var Noresult = BlurryContainer(
  height: 70.0,
  width: 370.0,
  blur: 5,
  elevation: 0,
  color: Colors.white.withOpacity(0.20),
  padding: const EdgeInsets.all(8),
  borderRadius: const BorderRadius.all(Radius.circular(20)),
  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
    Center(
      child: Text(
        'No Result Found',
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ]),
);

class CustomButton extends StatelessWidget {
  VoidCallback onPress;
  CustomButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: const BlurryContainer(
        height: 40.0,
        width: 150.0,
        color: Colors.green,
        elevation: 20.0,
        child: Center(
          child: Text(
            'Show Result',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
