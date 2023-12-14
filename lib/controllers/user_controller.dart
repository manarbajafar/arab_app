import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../HomeScreen.dart';
import '../login.dart';
import '/models/users.dart';

// this class to perform database user opreations
class UsersController extends GetxController {
  static UsersController get instance => Get.find();

  // final _auth_controller = Get.put(AuthController());
  final _db = FirebaseFirestore.instance;
  late final CollectionReference usersRef;
  // late final User user;

  //variables (Auth)
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    usersRef = _db.collection('users');
    firebaseUser = Rx<User?>(_auth.currentUser);
    // user = _auth_controller.firebaseUser.value!;
  }

  @override
  void onReady() {
    super.onReady();
    // firebaseUser = Rx<User?>(_auth.currentUser);
    // firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setFirstpage);
  }

  // _setFirstpage(User? user) {
  //   user == null ? Get.offAll(() => login()) : Get.offAll(() => HomeScreen());
  // }

  store_entry_time(DateTime entryTime) async {
    await _db.collection('users').doc(firebaseUser.value!.uid).set({
      "entry_time": FieldValue.arrayUnion([
        entryTime,
      ])
    }, SetOptions(merge: true));
    print('store_entry_time done!!');
  }

  store_exit_time(DateTime exitTime) async {
    await _db.collection('users').doc(firebaseUser.value!.uid).set({
      "exit_time": FieldValue.arrayUnion([
        exitTime,
      ])
    }, SetOptions(merge: true));
    print('store_exit_time done!!');
  }
}
