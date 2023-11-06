import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/app_service/firebase_service.dart';
import 'package:flutter_shop/app_service/theme_controller.dart';
import 'package:flutter_shop/constant/hive_box_names.dart';
import 'package:flutter_shop/constant/strings.dart';
import 'package:flutter_shop/modules/auth/controller/auth_controller.dart';
import 'package:flutter_shop/modules/auth/views/register_view.dart';
import 'package:flutter_shop/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'translations/app_translations.dart';
import 'utils/app_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseService();
  await _initPreAppServices();
  
  runApplication();
}

void runApplication() {
  AppUtility.log('Initializing App');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  AppUtility.log('App Initialized');
}

Future<void> _initPreAppServices() async {
  AppUtility.log('Initializing PreApp Services');
  await Hive.initFlutter();

  AppUtility.log('Registering Hive Adapters');

  AppUtility.log('Hive Adapters Registered');

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<String>(HiveBoxNames.themeMode);

  // Initialized Gex Services
  AppUtility.log('Initializing Get Services');
  Get.put(AppThemeController(), permanent: true);
 // Get.put(AuthController(), permanent: true);
  AppUtility.log('Get Services Initialized');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode _handleAppTheme(String mode) {
    if (mode == kDarkMode) {
      return ThemeMode.dark;
    }
    if (mode == kLightMode) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: (ctx, child) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: logic.getLightThemeData(),
          darkTheme: logic.getDarkThemeData(),
          getPages: AppPages.pages,
          // initialRoute: _handleAppInitialRoute(),
          home: const RegisterView(),
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'NG'),
        ),
      ),
    );
  }
}