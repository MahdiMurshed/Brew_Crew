import 'package:brew/model/brew.dart';
import 'package:brew/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollections =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollections.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  //brewlist from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => Brew(
            name: e.data['name'] ?? '',
            strength: e.data['strength'] ?? 0,
            sugars: e.data['sugars'] ?? '0'))
        .toList();
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollections.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollections.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
