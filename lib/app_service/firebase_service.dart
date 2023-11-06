import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shop/firebase_options.dart';
import 'package:flutter_shop/modules/auth/controller/auth_controller.dart';
import 'package:flutter_shop/utils/app_utility.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> initializeFirebaseService() async {
  AppUtility.log('Initializing Firebase Service');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthController());
  });
}
