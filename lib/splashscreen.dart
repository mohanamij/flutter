import 'package:blog_app/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Loginscreen.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: LoginScreen(),
        title: Text(
          'Mohana BlogApp',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        image: Image.asset('assets/download.jpg'),
        backgroundColor: Colors.pink,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.amber);
  }
}
