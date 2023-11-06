import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/user.dart';
import 'package:flutter_shop/routes/route_management.dart';
import 'package:flutter_shop/utils/app_utility.dart';
import 'package:get/get.dart';

import '../../../constant/firebase.dart';
import '../../../constant/strings.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User?>? firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  final FocusScopeNode focusNode = FocusScopeNode();
  final FocusScopeNode otpFocusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _showPassword = true.obs;
  final _showConfirmPassword = true.obs;

  bool get isLoading => _isLoading.value;
  bool get showPassword => _showPassword.value;
  bool get showConfirmPassword => _showConfirmPassword.value;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser!);
    firebaseUser!.bindStream(auth.userChanges());
    ever(firebaseUser!, _setInitialScreen);
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> signUp() async {
    if (firstNameTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }
    if (lastNameTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterLastName,
        StringValues.warning,
      );
      return;
    }
    if (emailTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    if (passwordTextController.text.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
  AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailTextController.text.trim(),
              password: passwordTextController.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      }).whenComplete(() {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        // RouteManagement.goToBack();
        RouteManagement.goToLoginView();
        AppUtility.showSnackBar(
          StringValues.registrationSuccessful,
          StringValues.success,
        );
      });
    } catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${e.toString()}', StringValues.error);
    }
  }

   Future<void> _login(String email, String password) async {
     if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

   }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "first_name": firstNameTextController.text.trim(),
      "id": userId,
      "email": emailTextController.text.trim(),
      "last_name": lastNameTextController.text.trim(),
      "cart": []
    });
  }

  _clearControllers() {
    firstNameTextController.clear();
    lastNameTextController.clear();
    emailTextController.clear();
    passwordTextController.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    AppUtility.log(StringValues.updated);
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser!.value!.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser!.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  _setInitialScreen(User? callback) {}
}
