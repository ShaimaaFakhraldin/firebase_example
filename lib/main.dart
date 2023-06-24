import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/real/splash_screen.dart';
import 'package:firebase_example/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'screens/login_page.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();




  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication',
      debugShowCheckedModeBanner: false,
      themeMode:AppColors.myThem,

      darkTheme: ThemeData(
        primaryColor: AppColors.primeryColor
      ),
      theme: ThemeData(
        primaryColor: AppColors.primeryColor,
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 24.0,
            ),
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 46.0,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: TextStyle(fontSize: 18.0),
        ),
      ),
      home: Splash(),
      // home: LoginPage(),
    );
  }
}
