import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:qr_gps_audio_video_player/home_screen.dart';
import 'dart:math' as Math;

import 'package:qr_gps_audio_video_player/web_view_qr_link.dart';

import 'audio_player.dart';

class GpsWithLocationScreen extends StatefulWidget {
  const GpsWithLocationScreen({Key? key}) : super(key: key);

  @override
  _GpsWithLocationScreenState createState() => _GpsWithLocationScreenState();
}

class _GpsWithLocationScreenState extends State<GpsWithLocationScreen> {
  Location location = new Location();
  StreamSubscription? _locationSubscription;
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  bool isPossibleToPopup = true;

  var audio1Lat = 37.612258493473085; // 북한산보국문역
  var audio1Lng = 127.00814595321324;
  var audio1Link = 'https://m.site.naver.com/0RHGn';
  var audio2Lat = 37.61038152972368; // 손가정터
  var audio2Lng = 127.0083829885178;
  var audio2Link = 'https://m.site.naver.com/0RHGG';
  var audio3Lat = 37.60927403081151; // 슬로카페 달팽이 (audio+video)
  var audio3Lng = 127.00852148748811;
  var audio3Link = 'https://m.site.naver.com/0RHHk';
  var video3Link = 'https://youtu.be/wvaj42BYyPY';
  var audio4Lat = 37.609019979227845; // 청년문간 (audio+video)
  var audio4Lng = 127.00911515092714;
  var audio4Link = 'https://m.site.naver.com/0RHHt';
  var video4Link = 'https://youtu.be/VYd0-FV9-xc';
  var video1Lat = 37.618274666147684; // 정릉천
  var video1Lng = 126.99756345863229;
  var video1Link = 'https://youtu.be/wvaj42BYyPY';
  var video2Lat = 37.60818191745648; // 정릉시장
  var video2Lng = 127.00857440098933;
  var video2Link = 'https://youtu.be/APeJF_7npN4';

  var yeonLat = 37.41842907372107;
  var yeonLng = 127.13505026023911;
  var yeonLink =
      'https://drive.google.com/file/d/1UXXf0Ol9MpgDGqPxdNRQ4G1xKuy-xTjg/view';
  var gamaroLat = 37.418876;
  var gamaroLng = 127.135583;
  var gamaroLink = 'https://youtu.be/wvaj42BYyPY';

  @override
  void initState() {
    super.initState();

    permissionCheck();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }

  permissionCheck() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      setState(() {
        _locationData = currentLocation;
      });

      if (isPossibleToPopup) {
        if (measure(gamaroLat, gamaroLng) < 100) {
          showPopup('gamaro', context);
        } else if (measure(yeonLat, yeonLng) < 15) {
          showPopup('yeon', context);
        } else if (measure(audio1Lat, audio1Lng) < 10) {
          showPopup('audio1', context, link1: audio1Link);
        } else if (measure(audio1Lat, audio1Lng) < 10) {
          showPopup('audio2', context, link1: audio2Link);
        } else if (measure(audio3Lat, audio3Lng) < 10) {
          showPopup('audio3', context, link1: audio3Link, link2: video3Link);
        } else if (measure(audio4Lat, audio4Lng) < 10) {
          showPopup('audio4', context, link1: audio4Link, link2: video4Link);
        } else if (measure(video1Lat, video1Lng) < 10) {
          showPopup('video1', context, link1: video1Link);
        } else if (measure(video2Lat, video2Lng) < 10) {
          showPopup('video2', context, link1: video2Link);
        }

        setState(() {
          isPossibleToPopup = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '위치기반 안내',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _locationData != null
            //     ? Text(_locationData!.time.toString())
            //     : SizedBox(),
            // _locationData != null
            //     ? Text(_locationData!.longitude.toString())
            //     : const Text('위치를 가져오는 중입니다.'),
            // _locationData != null
            //     ? Text(_locationData!.latitude.toString())
            //     : const CircularProgressIndicator(),
            // _locationData != null
            //     ? Text('연꽃: ${measure(yeonLat, yeonLng).toString()}m')
            //     : SizedBox(),
            // _locationData != null
            //     ? Text('가마로: ${measure(gamaroLat, gamaroLng).toString()}m')
            //     : SizedBox(),
            Text(
              '해당 장소 10m 범위 내로',
              style: TextStyle(
                fontSize: Get.width * 0.05,
              ),
            ),
            Text(
              '이동하면 안내창이 팝업됩니다.',
              style: TextStyle(
                fontSize: Get.width * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }

  measure(lat, lng) {
    // generally used geo measurement function
    var R = 6378.137; // Radius of earth in KM
    var dLat = lat * Math.pi / 180 - _locationData!.latitude! * Math.pi / 180;
    var dLon = lng * Math.pi / 180 - _locationData!.longitude! * Math.pi / 180;
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(_locationData!.latitude! * Math.pi / 180) *
            Math.cos(lat * Math.pi / 180) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    return d * 1000; // meters
  }

  showPopup(String request, BuildContext context,
      {String? link1, String? link2}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('링크 연결하기', // '게시글 수정/삭제하기'
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: Get.width * 0.05,
                )),
            content: Container(
              width: Get.width * 0.3,
              height: Get.height * 0.2,
              child: Column(children: [
                request == 'yeon' ||
                        request == 'gamaro' ||
                        request == 'audio1' ||
                        request == 'audio2' ||
                        request == 'audio3' ||
                        request == 'audio4'
                    ? ElevatedButton(
                        child: Container(
                          width: Get.width * 0.5,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '나래이션📣 바로가기',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: Get.width * 0.045),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.indigo),
                        onPressed: () async {
                          switch (request) {
                            case 'yeon':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: gamaroLink));
                              break;
                            case 'gamaro':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: gamaroLink));
                              break;
                            case 'audio1':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: audio1Link));
                              break;
                            case 'audio2':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: audio2Link));
                              break;
                            case 'audio3':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: audio3Link));
                              break;
                            case 'audio4':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: audio4Link));
                              break;
                          }
                        },
                      )
                    : SizedBox(),
                request == 'yeon' ||
                        request == 'gamaro' ||
                        request == 'video1' ||
                        request == 'video2' ||
                        request == 'video3' ||
                        request == 'video4'
                    ? ElevatedButton(
                        child: Container(
                          width: Get.width * 0.5,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '유튜브링크🎬 바로가기',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: Get.width * 0.045),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () async {
                          // Get.back();
                          // _locationSubscription!.cancel();
                          // Get.to(() => AudioPlayer());
                          switch (request) {
                            case 'yeon':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: gamaroLink));
                              break;
                            case 'gamaro':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: gamaroLink));
                              break;
                            case 'video1':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: video1Link));
                              break;
                            case 'video2':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: video2Link));
                              break;
                            case 'video3':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: video3Link));
                              break;
                            case 'video4':
                              Get.back();
                              _locationSubscription!.cancel();
                              Get.to(() => WebViewLink(link: video4Link));
                              break;
                          }
                        },
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '취소❌',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: Get.width * 0.045,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                        onPressed: () async {
                          Get.back();
                          setState(() {
                            isPossibleToPopup = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '홈으로🏠',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: Get.width * 0.045,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () async {
                          Get.back();
                          Get.offAll(() => HomeScreen());
                          // setState(() {
                          //   isPossibleToPopup = true;
                          // });
                        },
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
        });
  }
}
