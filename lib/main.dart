import 'package:flutter/material.dart';
import 'package:nextmusic/Views/screens/SongStatusScreen.dart';
import 'package:nextmusic/widgets/hidderDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SongStatusScreen(
          name: 'kana yari',
          album: '123',
          artist: '123',
          releaseDate: '123',
        )
        // HiddenDrawWithAppRoute(),
        );
  }
}
