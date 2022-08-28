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
    apiKey: 'AIzaSyCMGFvYHoSRkcTPdbZqkk2atcNiRc2xY8Y',
    appId: '1:968695725622:web:6fcc4af62835272445a297',
    messagingSenderId: '968695725622',
    projectId: 'project-donghaeng',
    authDomain: 'project-donghaeng.firebaseapp.com',
    databaseURL:
        'https://project-donghaeng-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'project-donghaeng.appspot.com',
    measurementId: 'G-4HCCZRPTVB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPYZxGje4v7ycu-6oi3PvufOhu7y1Ebpw',
    appId: '1:968695725622:android:b3cfbb9c26a539ff45a297',
    messagingSenderId: '968695725622',
    projectId: 'project-donghaeng',
    databaseURL:
        'https://project-donghaeng-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'project-donghaeng.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1QOSqG357_6htnbRgPlU2Q-W96XfQZTM',
    appId: '1:968695725622:ios:1c17b41fae4b415645a297',
    messagingSenderId: '968695725622',
    projectId: 'project-donghaeng',
    databaseURL:
        'https://project-donghaeng-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'project-donghaeng.appspot.com',
    iosClientId:
        '968695725622-scr95oo3710fj2g4skcia0jrpfcbg3f4.apps.googleusercontent.com',
    iosBundleId: 'com.donghaeng.donghaeng',
  );
}
