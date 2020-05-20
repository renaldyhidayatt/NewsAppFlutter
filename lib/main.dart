import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:NewsApp/views/homepage.dart';
import 'package:NewsApp/views/splash.dart';
import 'package:NewsApp/views/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return SplashPage();
        }
        if(!snapshot.hasData || snapshot.data == null){
          return LoginPage();
        }
        return HomePage();
      },
    );
  }
}
