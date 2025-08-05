import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/login.dart';
import 'package:mobileapp/subcategories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';



void main() {
  String finalMobileNumber;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
      routes: {
        '/home' : (context) => Home(),
        '/login' : (context) => Login(title: 'Flutter Home Page'),
        '/subcategories' : (context) => SubCategories()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var finalMobileNumber;
  @override
  void initState(){
    getStoredMobileNumber().whenComplete(
            () async{
              if(finalMobileNumber != null){
                print('length is');
                print(finalMobileNumber.length);
                Navigator.pushReplacementNamed(context, '/home',
                arguments: {'MobileNumber': finalMobileNumber});
              }else{
                Navigator.pushReplacementNamed(context, '/login');
              }
              ;
        }
    );
    FlutterNativeSplash.remove();
    super.initState();
  }

  Future getStoredMobileNumber() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedMobileNumber = sharedPreferences.getString('MobileNumber');
    setState(() {
      finalMobileNumber = obtainedMobileNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

