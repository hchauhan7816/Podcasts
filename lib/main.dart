import 'package:flutter/material.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:podcasts/views/podcastScreen.dart';
import 'package:podcasts/services/audioPlayer.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('${snapshot.error}');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: "Podcasts",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'CustomFont',
              primaryColor: primaryColor,
              accentColor: primaryColor,
            ),
            home: Home(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
