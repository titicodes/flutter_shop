import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/assets.dart';
import 'package:flutter_shop/constant/dimens.dart';
import 'package:get/get.dart';

import '../../../app_widgets/app_filled_btn.dart';
import '../../../app_widgets/app_outlined_btn.dart';
import '../../../app_widgets/asset_image.dart';
import '../../../app_widgets/unfocus_widget.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import '../controller/auth_controller.dart';



class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: Dimens.screenHeight,
          width: Dimens.screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AssetValues.secondScreenBackground,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [Dimens.boxHeight80, _buildBody(context)],
          ),
        )),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (logic) => Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsetsHorizDefault,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Dimens.boxHeight20,
                        NxAssetImage(
                          imgAsset: AssetValues.quadrant,
                          height: Dimens.thirty,
                          width: Dimens.thirty,
                        ),
                        Text(
                          StringValues.keliene,
                          style: AppStyles.style36Bold.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Dimens.boxHeight16,
                    Text(
                      StringValues.letRegister,
                      style: AppStyles.style36Bold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.alreadyHaveAccount,
                          style: AppStyles.style15Normal.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Dimens.boxWidth8,
                        Text(
                          StringValues.login,
                          style: AppStyles.style15Bold.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Dimens.boxHeight24,
                    _buildRegisterBody(context, logic),
                    Dimens.boxHeight20,
                    _buildRegisterButton(context, logic),
                    Dimens.boxHeight12,
                    _buildSocialButton(context, logic),
                    Dimens.boxHeight20
                  ],
                ),
              ),
            )));
  }

  Widget _buildRegisterBody(BuildContext context, AuthController logic) {
    return FocusScope(
      node: logic.focusNode,
      child: Column(
        children: [
          Dimens.boxHeight8,
          TextFormField(
            decoration: const InputDecoration(
              hintText: StringValues.email,
            ),
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.emailTextController,
            onEditingComplete: logic.focusNode.nextFocus,
          ),
          Dimens.boxHeight16,
          TextFormField(
            decoration: const InputDecoration(
              hintText: StringValues.firstName,
            ),
            keyboardType: TextInputType.name,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.firstNameTextController,
            onEditingComplete: logic.focusNode.nextFocus,
          ),
          Dimens.boxHeight16,
          TextFormField(
            decoration: const InputDecoration(
              hintText: StringValues.lastName,
            ),
            keyboardType: TextInputType.name,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.lastNameTextController,
            onEditingComplete: logic.focusNode.nextFocus,
          ),
          Dimens.boxHeight12,
          TextFormField(
            obscureText: logic.showPassword,
            decoration: InputDecoration(
              hintText: StringValues.password,
              suffixIcon: InkWell(
                onTap: logic.toggleViewPassword,
                child: Icon(
                  logic.showPassword
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                ),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.passwordTextController,
            onEditingComplete: logic.focusNode.nextFocus,
          ),
          Dimens.boxHeight12,
         
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, AuthController logic) {
    return NxFilledButton(
      onTap: () => logic.signUp(),
      label: StringValues.register.toUpperCase(),
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
    );
  }

  Widget _buildSocialButton(BuildContext context, AuthController logic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: NxOutlinedButton(
         // onTap: () => logic.handleGoogleSignIn(),
          label: StringValues.gmail,
          prefix: NxAssetImage(
            imgAsset: AssetValues.gmailIcon,
            height: Dimens.fourty,
            width: Dimens.thirty,
          ),
        )),
        Dimens.boxWidth12,
        Expanded(
            child: NxOutlinedButton(
          label: StringValues.facebook,
          prefix: NxAssetImage(
            imgAsset: AssetValues.facebookIcon,
            height: Dimens.fourty,
            width: Dimens.thirty,
          ),
        )),
      ],
    );
  }
}
