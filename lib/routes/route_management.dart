
import 'package:get/get.dart';

import 'app_pages.dart';

 class RouteManagement {
   /// Welcome ------------------------------------------------------------------
  static void goToWelcomeView() {
    Get.offAllNamed(AppRoutes.loginRegister);
  }
  static void gotoLoginRegisterView() {
    Get.toNamed(AppRoutes.loginRegister);
  }

   static void goToServerMaintenanceView() {
    Get.offAllNamed(AppRoutes.maintenance);
  }

  static void goToServerOfflineView() {
    Get.offAllNamed(AppRoutes.offline);
  }

  static void gotToErrorView() {
    Get.offAllNamed(AppRoutes.error);
  }

  static void goToNetworkErrorView() {
    Get.offAllNamed(AppRoutes.noNetwork);
  }

  /// Auth ---------------------------------------------------------------------
  static void goToLoginView() {
    Get.toNamed(AppRoutes.login);
  }

  static void goToRegisterView() {
    Get.toNamed(AppRoutes.signupPage);
  }

  static void gotoForgetPasswordView() {
    Get.toNamed(AppRoutes.forgetPasswordPage);
  }

  static void gotoResetPasswordPage() {
    Get.toNamed(AppRoutes.resetPasswordPage);
  }

  static void goToBack() {
    Get.toNamed(AppRoutes.loginRegister);
  }

  static void goToHomeView() {
    Get.toNamed(AppRoutes.homePage);
  }
}
