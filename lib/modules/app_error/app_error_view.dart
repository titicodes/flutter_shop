import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/assets.dart';
import 'package:flutter_shop/constant/dimens.dart';
import 'package:flutter_shop/constant/strings.dart';
import 'package:flutter_shop/constant/styles.dart';
import 'package:flutter_shop/utils/app_utility.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';


class AppErrorView extends StatelessWidget {
  const AppErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var errorMessage = Get.arguments as String? ?? 'An error occurred';
    var lastExitTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(lastExitTime) >=
            const Duration(seconds: 2)) {
          AppUtility.showSnackBar(
            'Press the back button again to exit the app',
            '',
            duration: 2,
          );
          lastExitTime = DateTime.now();

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimens.screenWidth * 0.75,
                  height: Dimens.screenWidth * 0.75,
                  child: const RiveAnimation.asset(
                    RiveAssets.error,
                    alignment: Alignment.center,
                  ),
                ),
                Dimens.boxHeight16,
                Text(
                  errorMessage,
                  style: AppStyles.style20Bold,
                  textAlign: TextAlign.center,
                ),
                Dimens.boxHeight8,
                Text(
                  StringValues.pleaseTryAgainLater,
                  style: AppStyles.style13Normal,
                  textAlign: TextAlign.center,
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
