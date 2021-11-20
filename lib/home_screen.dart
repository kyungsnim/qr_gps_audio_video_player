import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QrcodeScreen())), child: Text('Play with QR code'), style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GpsScreen())), child: Text('Play with GPS'), style: ElevatedButton.styleFrom(
              primary: Colors.indigoAccent,
            ),),
          ],
        ),
      )
    );
  }
}
