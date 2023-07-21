import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/firebase_ref/references.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';
import '../../models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  void uploadData() async {
    // change the status to loading...
    loadingStatus.value = LoadingStatus.loading;

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

    // loop through the question papers and upload the first question papers
    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "desciption": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions == null ? 0 : paper.questions!.length
      });

      // loop the questions in each paper and upload the questions for each paper and it's correct answer
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          'question': questions.question,
          'correct_answer': questions.correctAnswer,
        });

        // loop through the answers provided with each question and upload them
        for (var answers in questions.answers) {
          batch
              .set(questionPath.collection('answers').doc(answers.identifier), {
            'id': answers.identifier,
            'answer': answers.answer,
          });
        }
      }
    }

    // submit operation
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
