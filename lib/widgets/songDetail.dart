import 'package:flutter/material.dart';

class SongDetail extends StatelessWidget {
  final String text;
  final String name;
  const SongDetail({
    Key? key,
    required this.text,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5.0),
        Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}
