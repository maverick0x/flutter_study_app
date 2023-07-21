import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/question_paper/data_uploader.dart';
import 'firebase_ref/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {
  const DataUploaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataUploader controller = Get.put(DataUploader());

    return Scaffold(
      body: Center(
        child: Obx(
          () => Text(controller.loadingStatus.value == LoadingStatus.completed
              ? "Uploading Completed"
              : 'Uploading...'),
        ),
      ),
    );
  }
}
