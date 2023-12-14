import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String uid;
  String user_name;
  String user_phone;
  String entry_time; //array
  String exit_time; //array
  //List<int>? favorite_courses = [];

  Users(
      {required this.uid,
      required this.user_name,
      required this.user_phone,
      required this.entry_time,
      required this.exit_time});

  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; //getting complete object

    return Users(
        uid: document.id,
        user_name: data['user_name'],
        user_phone: data['user_phone'],
        entry_time: data['entry_time'],
        exit_time: data['exit_time']);
    //        favorite_courses: List.from(data['favorite_courses']));
  }
}
