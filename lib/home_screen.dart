import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_gps_audio_video_player/gps_with_location_screen.dart';
import 'package:qr_gps_audio_video_player/qrcode_screen.dart';

import 'gps_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '정릉골목을 거닐다',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.5,
                height: Get.height * 0.1,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrcodeScreen())),
                  child: Text(
                    'QR코드 오디오북',
                    style: TextStyle(
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                width: Get.width * 0.5,
                height: Get.height * 0.1,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GpsWithLocationScreen())),
                  child: Text(
                    '위치기반 안내',
                    style: TextStyle(
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
