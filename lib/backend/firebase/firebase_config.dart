import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDNJi2r9a2ZykbK_mYgtOqzbpKjDl2tDeA",
            authDomain: "golem-galaxy.firebaseapp.com",
            projectId: "golem-galaxy",
            storageBucket: "golem-galaxy.appspot.com",
            messagingSenderId: "193673580382",
            appId: "1:193673580382:web:94cd9e3f8d9bbd9b8209cf",
            measurementId: "G-6SQ9QMVHD8"));
  } else {
    await Firebase.initializeApp();
  }
}
