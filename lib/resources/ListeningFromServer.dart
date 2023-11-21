import 'package:flutter_acrcloud/flutter_acrcloud.dart';

class ServerDetails {
  final String host = 'identify-eu-west-1.acrcloud.com';
  final String apiKey = '6b6313ebfccb165584a74d5e0f432ff7';
  final String apiSecret = 'xcJGCVakKMIoRZT6AHEY7vN6nlXVTkxRtm4Qlftv';

  void ACRSetup() {
    ACRCloud.setUp(ACRCloudConfig(apiKey, apiSecret, host));
  }
}
