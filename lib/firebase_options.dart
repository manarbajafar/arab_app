// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAnph9vNvZvXd2X00sk474rcYA70-q8TCE',
    appId: '1:708228855925:web:4b6e39171b949ccd35203c',
    messagingSenderId: '708228855925',
    projectId: 'arab-app-33851',
    authDomain: 'arab-app-33851.firebaseapp.com',
    storageBucket: 'arab-app-33851.appspot.com',
    measurementId: 'G-0QN4WV9V3D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5AlQ0tpO91fbQyUpmG2t05fxKjpD6Mjk',
    appId: '1:708228855925:android:b2c34b7e6ce265ea35203c',
    messagingSenderId: '708228855925',
    projectId: 'arab-app-33851',
    storageBucket: 'arab-app-33851.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCebEhLP0D_QTigVWnwSyutI6gSljvwA9w',
    appId: '1:708228855925:ios:fdfd315bb41c353235203c',
    messagingSenderId: '708228855925',
    projectId: 'arab-app-33851',
    storageBucket: 'arab-app-33851.appspot.com',
    iosBundleId: 'com.example.arabApp',
  );
}
