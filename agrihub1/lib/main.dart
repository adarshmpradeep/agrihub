import 'package:agrihub1/providers/user_provider.dart';
import 'package:agrihub1/responsive/responsive_layout_screen.dart';
import 'package:agrihub1/screens/login_screen.dart';

import 'package:agrihub1/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive/mobile_screen_layout.dart';
import 'responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDvXUKDpNtdneKesTITCSEbpXu1eME6cTY',
        appId: '1:583714062875:web:cc826e9b91fc7d2cd66ebe',
        messagingSenderId: '583714062875',
        storageBucket: "agrihub-22907.appspot.com",
        projectId: 'agrihub-22907',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agrihub',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        //home: const ResponsiveLayout(
        //webScreenLayout: WebScreenLayout(),
        // mobileScreenLayout: MobileScreenLayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
