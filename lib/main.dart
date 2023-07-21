import 'package:flutter/material.dart';

import 'screens/splash/introduction/introduction.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(StudyApp());
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppIntroductionScreen(),
    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DataUploaderScreen(),
//     ),
//   );
// }
