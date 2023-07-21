import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

// Reference for the papers
final questionPaperRF = firestore.collection('questionPaper');

// Create a new collection that depends on the first collection; questionPaper
DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRF.doc(paperId).collection('questions').doc(questionId);
