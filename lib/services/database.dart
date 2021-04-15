import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DBmethods {
  getAllPodcastsLink() async {
    return await FirebaseFirestore.instance
        .collection("podcast_id")
        .snapshots();
  }

  getSearchList(String val) async {
    return await FirebaseFirestore.instance
        .collection("podcast_id")
        .orderBy("p_name")
        .startAt([val])
        .endAt([val + '\uf8ff'])
        .get()
        .then((snapshot) {
          return snapshot;
        });
  }
}
