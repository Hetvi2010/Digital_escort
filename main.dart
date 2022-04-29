import 'package:digital_escort/verify.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'reg.dart';
import 'homepage.dart';
import 'verification.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:firebase_core/firebase_core.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes:{
        '/' : (context) => const Login(),
        '/register' : (context) => const Register(),
        '/homepage': (context) => const HomePage(),
        '/view': (context) => const VerifyRequest(),
        '/pverify': (context) => const Passwordverify(),
      }
    );
  }
}
