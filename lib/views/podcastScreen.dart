import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/services/audioPlayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  final String p_link;
  final String p_name, p_image;
  Player({this.p_link, this.p_name, this.p_image});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool playing = true;
  bool loading = true;

  String name, img_name;
  IconData playButton = Icons.pause_rounded;

  AudioPlayer audioPlayer = AudioPlayer();

  Duration duration = new Duration();
  Duration currTime = new Duration();
  AudioPlayerState audioPlayerState;

  String tt;

  @override
  void initState() {
    name = widget.p_name;
    img_name = widget.p_image;
    playing = true;
    super.initState();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        loading = false;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        currTime = d;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState a) {
      setState(() {
        audioPlayerState = a;
      });
    });

    play(widget.p_link);
    tt = currTime.toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stop();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              stop();
              Navigator.pop(context);
            },
            child: Text(
              "Back",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset("images/icons/back.svg"),
            padding: EdgeInsets.only(left: defaultPadding),
            onPressed: () {
              stop();
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(60, 50),
                          bottomLeft: Radius.elliptical(60, 50))),
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        height: 270,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                            image: NetworkImage(img_name),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: defaultMargin),
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: primaryColor,
                            trackHeight: 1,
                            thumbColor: primaryColor,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                            inactiveTrackColor: Colors.grey[500],
                          ),
                          child: Slider(
                            value: currTime.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                seekToValue(value);
                              });
                            },
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            currTime.toString().split('.').first,
                            style: TextStyle(fontSize: 15),
                          ),
                          Spacer(),
                          Text(
                            duration.toString().split('.').first,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin / 1.5,
                    vertical: defaultMargin,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: defaultPadding / 2,
                    horizontal: defaultPadding * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          pause();
                        },
                        child: Container(
                          child: Icon(
                            Icons.skip_previous_rounded,
                            color: Colors.grey[850],
                            size: 40,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (playing) {
                            pause();
                            setState(() {
                              playButton = Icons.play_arrow_rounded;
                              playing = false;
                            });
                          } else {
                            play(widget.p_link);
                            setState(() {
                              playButton = Icons.pause_rounded;
                              playing = true;
                            });
                          }
                        },
                        child: Container(
                          child: loading
                              ? SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: CircularProgressIndicator())
                              : Icon(
                                  playButton,
                                  color: Colors.grey[850],
                                  size: 55,
                                ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          stop();
                        },
                        child: Container(
                          child: Icon(
                            Icons.skip_next_rounded,
                            color: Colors.grey[850],
                            size: 40,
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void seekToValue(double val) {
    int p = val.toInt();
    Duration pos = Duration(seconds: p);
    seek(pos);
  }

  play(String file) {
    audioPlayer.play(file);
  }

  pause() {
    audioPlayer.pause();
  }

  stop() {
    audioPlayer.stop();
    seek(duration);
    currTime = duration;
  }

  seek(Duration val) {
    audioPlayer.seek(val);
  }
}
