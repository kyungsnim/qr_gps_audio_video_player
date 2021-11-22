import 'package:flutter/material.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:qr_gps_audio_video_player/widgets/loading_indicator.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({Key? key}) : super(key: key);

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  TargetPlatform? _platform;

  ChewieAudioController? _chewieAudioController;
  ChewieAudio? playerWidget;

  final _videoPlayerController = VideoPlayerController.asset(
      'assets/audios/sound1.wav');

  // final _videoPlayerController = VideoPlayerController.network(
  //     'https://drive.google.com/file/d/18LUe8qKi-b3a2N7guk-AOLJB4cHRdsjR/view');

  @override
  void initState() {
    initialVideoPlayer();
    // initialAudioPlayer();
    // initialAudioWidget();
    Future.delayed(Duration(seconds: 3)).then((_) => initialAudioWidget());
    super.initState();
  }

  initialAudioPlayer() {
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  initialAudioWidget() {
    if(_chewieAudioController != null) {
      setState(() {
        playerWidget = ChewieAudio(
          controller: _chewieAudioController!,
        );
      });
    }
  }
  initialVideoPlayer() async {
    await _videoPlayerController.initialize().then((_) {
      initialAudioPlayer();
    });
  }

  @override
  void dispose() {
    if(_chewieAudioController != null) {
      _chewieAudioController!.pause();
      _chewieAudioController!.dispose();
    }
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오디오 재생', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _chewieAudioController != null && _chewieAudioController!.videoPlayerController.value.isInitialized
                  ? ChewieAudio(
                controller: _chewieAudioController!,
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loadingIndicator(),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (_chewieAudioController != null) _chewieAudioController!.dispose();
                      _videoPlayerController.pause();
                      _videoPlayerController.seekTo(const Duration());
                      _chewieAudioController = ChewieAudioController(
                        videoPlayerController: _videoPlayerController,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Audio 1"),
                  ),
                ),
              ),
              // Expanded(
              //   child: TextButton(
              //     onPressed: () {
              //       setState(() {
              //         if (_chewieAudioController != null) _chewieAudioController!.dispose();
              //         _videoPlayerController2.pause();
              //         _videoPlayerController2.seekTo(const Duration());
              //         _chewieAudioController = ChewieAudioController(
              //           videoPlayerController: _videoPlayerController2,
              //           autoPlay: true,
              //           looping: true,
              //         );
              //       });
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.symmetric(vertical: 16.0),
              //       child: Text("Audio 2"),
              //     ),
              //   ),
              // )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.android;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Android controls"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.iOS;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
