import 'package:flutter_shop/modules/auth/binding/auth_binding.dart';
import 'package:flutter_shop/modules/auth/views/login_view.dart';
import 'package:flutter_shop/modules/auth/views/register_view.dart';
import 'package:flutter_shop/modules/no_network/no_network_view.dart';
import 'package:flutter_shop/modules/server_maintenance/server_maintenance_view.dart';
import 'package:get/get.dart';

import '../modules/app_error/app_error_view.dart';
import '../modules/auth/views/login_register.dart';
import '../modules/server_offline_view.dart';

part 'app_routes.dart';

class AppPages {
  static var defaultTransition = Transition.circularReveal;
  static final pages = [
    GetPage(
      name: AppRoutes.maintenance,
      page: ServerMaintenanceView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.offline,
      page: ServerOfflineView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.error,
      page: AppErrorView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.noNetwork,
      page: NoNetworkView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.loginSignUpPage,
      page: LoginRegister.new,
      transitionDuration: transitionDuration,
      binding: AuthBinding(),
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.signupPage,
      page: RegisterView.new,
      transitionDuration: transitionDuration,
      binding: AuthBinding(),
      transition: defaultTransition,
    ),
    GetPage(
      name: AppRoutes.login,
      page: LoginView.new,
      transitionDuration: transitionDuration,
      binding: AuthBinding(),
      transition: defaultTransition,
    )
  ];

  static var transitionDuration = const Duration(milliseconds: 500);
}
