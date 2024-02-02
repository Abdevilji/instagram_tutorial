import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_tutorial/Screens/login_screen.dart';
import 'package:instagram_tutorial/providers/user_providers.dart';
import 'package:instagram_tutorial/utils/colors.dart';
import 'package:instagram_tutorial/responsive/MobileScreenLayout.dart';
import 'package:instagram_tutorial/responsive/WebScreenLayout.dart';
import 'package:instagram_tutorial/responsive/responsive_layout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Screens/signup_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDsQlvoqs9m6Le78QjvIypL1jx7aKmpqtg",
        messagingSenderId: "807844303698",
        appId: "1:807844303698:web:73f071a1beeba6d853208b",
        projectId: "instagram-tutorial-56e03",
        storageBucket: "instagram-tutorial-56e03.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram tutorial',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: const ResponsiveLayout(
        //     webScreenLayout: WebScreenLayout(),
        //     mobileScreenLayout: MobileScreenLayout(),) ,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return Login_Screen();
          },
        ),
      ),
    );
  }
}
