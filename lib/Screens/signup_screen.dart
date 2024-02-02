import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_tutorial/Screens/login_screen.dart';
import 'package:instagram_tutorial/resources/auth_methods.dart';
import 'package:instagram_tutorial/utils/colors.dart';
import 'package:instagram_tutorial/utils/utils.dart';
import 'package:instagram_tutorial/widgets/text_field_input.dart';

import '../responsive/MobileScreenLayout.dart';
import '../responsive/WebScreenLayout.dart';
import '../responsive/responsive_layout_screen.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void signupuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      username: usernameController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          )));
      // showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )));
    }
  }

  void navigatetologin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Login_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),

            //logo svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              //don't use without activating pubspec
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),

            const SizedBox(
              height: 64,
            ),
            //dummy profile
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2247726673.jpg'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.blue.shade500,
                    ))
              ],
            ),

            const SizedBox(
              height: 24,
            ),
            //text username input
            TextFieldInput(
              textInputType: TextInputType.text,
              textEditingController: usernameController,
              hintText: "Enter Your Username",
            ),
            const SizedBox(
              height: 24,
            ),
            //text email input
            TextFieldInput(
              textInputType: TextInputType.emailAddress,
              textEditingController: emailController,
              hintText: "Enter Your Email",
            ),
            //space
            const SizedBox(
              height: 24,
            ),
            //text input password
            TextFieldInput(
              textInputType: TextInputType.text,
              textEditingController: passwordController,
              hintText: "Enter Your Password",
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            //bio input
            TextFieldInput(
              textInputType: TextInputType.text,
              textEditingController: bioController,
              hintText: "Enter Your Bio",
            ),
            const SizedBox(
              height: 24,
            ),
            //button login
            InkWell(
              onTap: signupuser,
              // print(res);

              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign Up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
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
                  child: const Text("Do have an account?"),
                ),
                GestureDetector(
                  onTap: navigatetologin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Log in",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
            //transitioon
          ],
        ),
      )),
    );
  }
}
