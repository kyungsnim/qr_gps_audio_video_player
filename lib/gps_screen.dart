// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GpsScreen extends StatefulWidget {
//   const GpsScreen({Key? key}) : super(key: key);
//
//   @override
//   _GpsScreenState createState() => _GpsScreenState();
// }
//
// class _GpsScreenState extends State<GpsScreen> {
//   StreamSubscription? _positionStream;
//   bool getCurrentPositionStatus = true;
//   // Stream<Position>? _streamPosition;
//   Position? _position;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _determinePosition();
//     if(getCurrentPositionStatus) {
//       getCurrentPositionStream();
//     }
//   }
//
//   _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           getCurrentPositionStatus = false;
//         });
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       setState(() {
//         getCurrentPositionStatus = false;
//       });
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//   }
//
//   getCurrentPositionStream() {
//     _positionStream =
//         Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.low)
//             .listen((position) {
//       print('getCurrentPositionStream');
//
//       setState(() {
//         _position = position;
//       });
//     });
//   }
//
//   getCurrentPosition() async {
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
//         .then((val) {
//       print('getCurrentPosition');
//       if (mounted) {
//         print('${_position!.longitude} / ${_position!.latitude}');
//         setState(() {
//           _position = val;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     _positionStream!.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('현재 위치'),
//           centerTitle: true,
//           backgroundColor: Colors.green,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
//                   //   getCurrentPosition();
//                   //   print(1);
//                   // });
//                   getCurrentPosition();
//                 },
//                 child: const Text('현재 위치 가져오기'),
//               ),
//               _position != null
//                   ? Text(_position!.longitude.toString())
//                   : const Text('위치를 가져오는 중입니다.'),
//               _position != null
//                   ? Text(_position!.latitude.toString())
//                   : const CircularProgressIndicator(),
//               // _streamPosition != null
//               //     ? Text(_streamPosition!.last.toString())
//               //     : const Text('위치를 가져오는 중입니다.'),
//               // _streamPosition != null
//               //     ? Text(_streamPosition!.latitude.toString())
//               //     : const CircularProgressIndicator(),
//             ],
//           ),
//         ));
//   }
// }
