import 'package:flutter/material.dart';
import 'package:nextmusic/Views/screens/downloadingScreen.dart';
import 'package:nextmusic/resources/downloading%20process/downloading_process.dart';
import 'package:nextmusic/utils/contants.dart';
import 'package:nextmusic/widgets/songDetail.dart';
import 'package:url_launcher/url_launcher.dart';

class SongStatusScreen extends StatefulWidget {
  final String name;
  final String album;
  final String artist;
  final String releaseDate;

  SongStatusScreen({
    Key? key,
    required this.name,
    required this.album,
    required this.artist,
    required this.releaseDate,
  }) : super(key: key);

  @override
  State<SongStatusScreen> createState() => _SongStatusScreenState();
}

class _SongStatusScreenState extends State<SongStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: const Text('Matched Music'),
        centerTitle: true,
        backgroundColor: backgroundclr,
        elevation: 0,
      ),
      backgroundColor: backgroundclr,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  height: 250.0,
                  width: 365,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        offset: const Offset(2, 2),
                        color: Colors.grey.shade400,
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/radio.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri _uri = Uri.parse(
                              'https://www.youtube.com/results?search_query=${widget.name}');

                          if (await canLaunchUrl(_uri)) {
                            await launchUrl(_uri);
                          }
                        },
                        child: Container(
                          child: const Icon(
                            Icons.play_arrow,
                            size: 60.0,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  color: Colors.blue.shade700,
                                  blurRadius: 10.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'PLAY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Downloading(),
                      SizedBox(height: 10.0),
                      Text(
                        'DOWNLOAD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
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
                    children: [
                      SongDetail(
                        text: 'Track Name',
                        name: widget.name,
                      ),
                      SongDetail(
                        text: 'Album',
                        name: widget.album,
                      ),
                      SongDetail(
                        text: 'Artist',
                        name: widget.artist,
                      ),
                      SongDetail(
                        text: 'Release Date',
                        name: widget.releaseDate,
                      ),
                    ],
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
