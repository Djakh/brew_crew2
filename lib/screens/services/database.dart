import 'package:brew_crew2/models/brew.dart';
import 'package:brew_crew2/models/user1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

//collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugar': sugar, 'name': name, 'strength': strength});
  }

// brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.data()['name'] ?? '',
          sugar: doc.data()['sugar'] ?? '0',
          strength: doc.data()['strength'] ?? 0);
    }).toList();
  }

//document data from snapshot

  DocumentData _documentDataFromSnapshot(DocumentSnapshot snapshot) {
    return DocumentData(
        uid: uid,
        name: snapshot.data()['name'],
        sugar: snapshot.data()['sugar'],
        strength: snapshot.data()['strength']);
  }

  Stream<List<Brew>> get brews {
    return brewCollection
        .snapshots()
//.map(_brewListFromSnapshot);
        .map((QuerySnapshot snapshot) => _brewListFromSnapshot(snapshot));
  }

//get user document

  Stream<DocumentData> get documentData {
    return brewCollection.doc(uid).snapshots()
    .map((DocumentSnapshot snapshot) => _documentDataFromSnapshot(snapshot));
  }
}
