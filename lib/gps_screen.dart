import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({Key? key}) : super(key: key);

  @override
  _GpsScreenState createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  Position? position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await getCurrentPosition();
  }

  getCurrentPosition() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((val) {
      setState(() {
        position = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('출퇴근 시간 입력'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    getCurrentPosition();
                  },
                  child: const Text('현재 위치 가져오기')),
              position != null
                  ? Text(position!.longitude.toString())
                  : const Text('위치를 가져오는 중입니다.'),
              position != null
                  ? Text(position!.latitude.toString())
                  : const CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
