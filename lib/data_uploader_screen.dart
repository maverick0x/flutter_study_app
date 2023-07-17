import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/question_paper/data_uploader.dart';

class DataUploaderScreen extends StatelessWidget {
  const DataUploaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataUploader controller = Get.put(DataUploader());

    return const Scaffold(
      body: Center(
        child: Text("Uploading"),
      ),
    );
  }
}
