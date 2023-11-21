import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:nextmusic/Views/screens/SongStatusScreen.dart';
import 'package:nextmusic/resources/ListeningFromServer.dart';
import 'package:nextmusic/utils/contants.dart';
import 'package:nextmusic/widgets/helpers.dart';

final session = ACRCloud.startSession();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ACRCloudResponseMusicItem? music;
  bool Notreconizing = false;
  bool reconizing = true;
  bool blink = false;
  ServerDetails ACRSetup = ServerDetails();
  String songName = '';
  String Album = '';
  String artist = '';
  String ReleaseDate = '';
  bool noresult = false;
  @override
  void initState() {
    ACRSetup.ACRSetup();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundclr,
        elevation: 0,
      ),
      backgroundColor: backgroundclr,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: width,
            height: height,
            child: Column(
              children: [
                const SizedBox(height: 60.0),
                TapListenText,
                const SizedBox(height: 20.0),
                if (blink == true) CancelText,
                Builder(
                  builder: (context) => AvatarGlow(
                    endRadius: 200.0,
                    animate: Notreconizing,
                    child: GestureDetector(
                      onTap: () async {
                        setState(
                          () {
                            Notreconizing = reconizing;
                            blink = true;
                            music = null;
                            noresult = false;
                          },
                        );
                        final session = ACRCloud.startSession();

                        final result = await session.result;

                        if (result == null) {
                          // Cancelled.

                          return;
                        } else if (result.metadata == null) {
                          // no result
                          noresult = true;
                          setState(() {
                            Notreconizing = false;
                            blink = false;
                          });
                          return;
                        }

                        setState(
                          () {
                            music = result.metadata!.music.first;
                            if (music != null) {
                              Notreconizing = false;
                              blink = false;
                            }
                          },
                        );
                        if (music! != null) {
                          songName = music!.title;
                          Album = music!.album.name;
                          artist = music!.artists.first.name;
                          ReleaseDate = music!.releaseDate;
                        }
                      },
                      onDoubleTap: () {
                        setState(
                          () {
                            session.cancel();
                            Notreconizing = false;
                            blink = false;
                          },
                        );
                      },
                      child: Material(
                        shape: const CircleBorder(),
                        elevation: 40,
                        child: Container(
                          padding: const EdgeInsets.all(42.0),
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blink == false ? buttonBlue : buttonRed,
                          ),
                          child: Image.asset(
                            'assets/images/music-bars.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (music != null)
                  CustomButton(
                    onPress: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => SongStatusScreen(
                                name: songName,
                                album: Album,
                                artist: artist,
                                releaseDate: ReleaseDate,
                              )),
                        ),
                      );
                    }),
                  ),
                if (noresult == true) Noresult,
                if (blink == true) listenText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
