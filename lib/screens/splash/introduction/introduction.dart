import 'package:flutter/material.dart';

import '../../../widgets/app_circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(
              Icons.star,
              size: 65,
              color: Colors.amber,
            ),
            const Text(
                'This is a study app. You can use it as you want. If you uderstand how it works, you will be able to scale it. With this you will master firebase backend and flutter front end'),
            AppCircleButton(
              onTap: () => null,
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
