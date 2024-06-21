// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC79FKtepu2FLMeZaseWeveVDhdVhNIPXE',
    appId: '1:251834196047:web:1561aeb862c705ca868a3a',
    messagingSenderId: '251834196047',
    projectId: 'qrattendance-1834c',
    authDomain: 'qrattendance-1834c.firebaseapp.com',
    databaseURL: 'https://qrattendance-1834c-default-rtdb.firebaseio.com',
    storageBucket: 'qrattendance-1834c.appspot.com',
    measurementId: 'G-GEV0BD6K28',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8d8xBNOaESu66XqnEQSXyMlVKNXrCxJA',
    appId: '1:251834196047:android:48db2046a2c7406c868a3a',
    messagingSenderId: '251834196047',
    projectId: 'qrattendance-1834c',
    databaseURL: 'https://qrattendance-1834c-default-rtdb.firebaseio.com',
    storageBucket: 'qrattendance-1834c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5lv0SP81gdIL0cjoAetx34wMtZU9DxMQ',
    appId: '1:251834196047:ios:f728b71a18c72a45868a3a',
    messagingSenderId: '251834196047',
    projectId: 'qrattendance-1834c',
    databaseURL: 'https://qrattendance-1834c-default-rtdb.firebaseio.com',
    storageBucket: 'qrattendance-1834c.appspot.com',
    iosBundleId: 'com.example.titansAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5lv0SP81gdIL0cjoAetx34wMtZU9DxMQ',
    appId: '1:251834196047:ios:f728b71a18c72a45868a3a',
    messagingSenderId: '251834196047',
    projectId: 'qrattendance-1834c',
    databaseURL: 'https://qrattendance-1834c-default-rtdb.firebaseio.com',
    storageBucket: 'qrattendance-1834c.appspot.com',
    iosBundleId: 'com.example.titansAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC79FKtepu2FLMeZaseWeveVDhdVhNIPXE',
    appId: '1:251834196047:web:5b912944d2f647ba868a3a',
    messagingSenderId: '251834196047',
    projectId: 'qrattendance-1834c',
    authDomain: 'qrattendance-1834c.firebaseapp.com',
    databaseURL: 'https://qrattendance-1834c-default-rtdb.firebaseio.com',
    storageBucket: 'qrattendance-1834c.appspot.com',
    measurementId: 'G-SD0DPX7J00',
  );
}