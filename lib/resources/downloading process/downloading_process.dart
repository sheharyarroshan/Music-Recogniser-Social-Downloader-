import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nextmusic/resources/downloading%20process/result.dart';
import 'package:nextmusic/utils/contants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Downloading extends StatefulWidget {
  const Downloading({Key? key}) : super(key: key);

  @override
  State createState() => _DownloadingState();
}

class _DownloadingState extends State {
  _showBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: backgroundclr,
      context: context,
      builder: ((context) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Please paste link first then choose download mode',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      height: 50.0,
                      minWidth: 150.0,
                      color: buttonRed,
                      splashColor: Colors.green,
                      onPressed: (() {
                        downloadVideo(audio, title, ".mp3");
                      }),
                      child: Text(
                        'Audio (mp3) $filesize_audio',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      height: 50.0,
                      minWidth: 150.0,
                      color: buttonRed,
                      splashColor: Colors.green,
                      onPressed: (() {
                        downloadVideo(video, title, ".mp4");
                      }),
                      child: Text(
                        'Video (mp4) $filesize_video',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: white,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: "Please paste Youtube link to download",
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: white,
                        ),
                        onPressed: () async {
                          setState(() {
                            url = textController.text;
                            isLoading = true;
                          });
                          await Result.connectToApi(url).then((value) {
                            result = value;
                            setState(() {
                              title = result.title!;
                              thumb = result.thumb!;
                              filesize_audio = result.filesize_audio!;
                              filesize_video = result.filesize_video!;
                              audio = result.audio!;
                              audio_asli = result.audio_asli!;
                              video = result.video!;
                              video_asli = result.video_asli!;
                              isLoading = false;
                            });
                          });
                        },
                      )),
                  onSubmitted: (url) => Result.connectToApi(url).then((value) {
                    setState(() {
                      title = result.title!;
                      thumb = result.thumb!;
                      filesize_audio = result.filesize_audio!;
                      filesize_video = result.filesize_video!;
                      audio = result.audio!;
                      audio_asli = result.audio_asli!;
                      video = result.video!;
                      video_asli = result.video_asli!;
                    });
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Text(progress),
            ],
          ),
        );
      }),
    );
  }

  late Result result;
  String url = "";
  String title = "";
  String thumb = "";
  String filesize_audio = "";
  String filesize_video = "";
  String audio = "";
  String audio_asli = "";
  String video = "";
  String video_asli = "";
  String progress = '';

  bool isLoading = false;
  String directory = "";

  final textController = TextEditingController();
  final padding = const EdgeInsets.all(8.0);
  var dio = Dio();

  Future getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory!.path;
  }

  Future downloadVideo(String url, String name, String format) async {
    getDownloadPath().then((value) {
      setState(() {
        isLoading = true;
        directory = value!;
      });
    });

    final baseStorage = await getExternalStorageDirectory();
    await dio.download(url, directory + "/" + name + format,
        onReceiveProgress: (rec, total) {
      setState(() {
        isLoading = false;
        progress =
            "Downloading..." + ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });
    setState(() {
      if (progress.contains('100')) {
        progress = 'Download Successfully';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(8.0);
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        child: Icon(
          Icons.download,
          size: 60.0,
          color: Colors.white,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff0B634E),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: Color(0xff0B634E),
                blurRadius: 20.0),
          ],
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text("Youtube Downloader"),
    //   ),
    //   body: Center(
    //     child: Padding(
    //       padding: padding,
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: padding,
    //             child: Column(
    //               children: [
    //                 // Image.network(
    //                 //   thumb != ""
    //                 //       ? thumb
    //                 //       : "https://i.ibb.co/qYTFsDx/placeholder.png",
    //                 //   height: 150,
    //                 //   width: 150,
    //                 // ),
    //                 Text(title),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     ElevatedButton(
    //                       onPressed: () {
    //                         downloadVideo(audio, title, ".mp3");
    //                       },
    //                       child: Row(
    //                         children: [
    //                           Text(
    //                             "MP3",
    //                             style: TextStyle(fontSize: 16),
    //                           ),
    //                           SizedBox(
    //                             width: 10,
    //                           ),
    //                           Text(
    //                             filesize_audio,
    //                             style: TextStyle(fontSize: 12),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 20,
    //                     ),
    //                     ElevatedButton(
    //                       onPressed: () {
    //                         downloadVideo(video, title, ".mp4");
    //                       },
    //                       child: Row(
    //                         children: [
    //                           Text(
    //                             "MP4",
    //                             style: TextStyle(fontSize: 16),
    //                           ),
    //                           SizedBox(
    //                             width: 10,
    //                           ),
    //                           Text(
    //                             filesize_video,
    //                             style: TextStyle(fontSize: 12),
    //                           )
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: padding,
    //             child: TextField(
    //               controller: textController,
    //               decoration: InputDecoration(
    //                   contentPadding: EdgeInsets.all(8.0),
    //                   hintText: "Paste link youtubenya disini cantik",
    //                   suffixIcon: IconButton(
    //                     icon: Icon(Icons.search),
    //                     onPressed: () async {
    //                       setState(() {
    //                         url = textController.text;
    //                         isLoading = true;
    //                       });
    //                       await Result.connectToApi(url).then((value) {
    //                         result = value;
    //                         setState(() {
    //                           title = result.title!;
    //                           thumb = result.thumb!;
    //                           filesize_audio = result.filesize_audio!;
    //                           filesize_video = result.filesize_video!;
    //                           audio = result.audio!;
    //                           audio_asli = result.audio_asli!;
    //                           video = result.video!;
    //                           video_asli = result.video_asli!;
    //                           isLoading = false;
    //                         });
    //                       });
    //                     },
    //                   )),
    //               onSubmitted: (url) => Result.connectToApi(url).then((value) {
    //                 setState(() {
    //                   title = result.title!;
    //                   thumb = result.thumb!;
    //                   filesize_audio = result.filesize_audio!;
    //                   filesize_video = result.filesize_video!;
    //                   audio = result.audio!;
    //                   audio_asli = result.audio_asli!;
    //                   video = result.video!;
    //                   video_asli = result.video_asli!;
    //                 });
    //               }),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           isLoading
    //               ? Center(
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 )
    //               : Text(progress),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
