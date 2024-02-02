import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_tutorial/Screens/signup_screen.dart';
import 'package:instagram_tutorial/resources/auth_methods.dart';
import 'package:instagram_tutorial/utils/colors.dart';
import 'package:instagram_tutorial/utils/utils.dart';
import 'package:instagram_tutorial/widgets/text_field_input.dart';

import '../responsive/MobileScreenLayout.dart';
import '../responsive/WebScreenLayout.dart';
import '../responsive/responsive_layout_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          )));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigatetosignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Signup_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            //logo svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              //don't use without activating pubspec
              colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),

            //text email input
            TextFieldInput(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: "Enter Your Email"),
            //space
            const SizedBox(
              height: 24,
            ),
            //text input password
            TextFieldInput(
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              hintText: "Enter Your Password",
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            //button login
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Log In"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(flex: 2, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                   Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Don't have an account?"),
                  ),
                GestureDetector(
                  onTap: navigatetosignup,
                child :Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: const Text("Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),)
              ],
            )
            //transition
          ],
        ),
      )),
    );
  }
}
