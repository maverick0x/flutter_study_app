import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/firebase_ref/references.dart';
import 'package:get/get.dart';

import '../../models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  void uploadData() async {
    // Get all json files path in the DB folder
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((element) =>
            element.startsWith('assets/DB/papers') && element.contains('.json'))
        .toList();

    // Get each file and load their contents into a model inside of a list
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String paperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(paperContent)));
    }

    // Create a variable to hold the firestore instance for this operation.
    final firestore = FirebaseFirestore.instance;
    // Create a batch variable since we're uploading in batches.
    var batch = firestore.batch();
    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "desciption": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions == null ? 0 : paper.questions!.length
      });
    }
    await batch.commit();
  }
}
