import 'package:agenda_de_contatos/pages/login.dart';
import 'package:agenda_de_contatos/pages/sign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agenda_de_contatos/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}  // main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: login.tag,
      routes: {
        Home.tag: (context) => Home(),
        login.tag: (context) => login(),
        sign.tag: (context) => sign()
      },  // routes
    );
  }  // build
}  // MyApp