import 'package:flutter/material.dart';
import 'data.dart';
import 'database.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _rollNo = '';
  String _userName = '';
  String _password = '';
  List<String> errors = [
    'Wrong Username or Password',
    'server might be busy please try after some time',
  ];
  bool showerror = false;
  int errorIndex = 0;
  bool isObscure = true;

  void login() async {
    String s = await Db.login();
    s = jsonDecode(s);
    if (s == 'Login Successfull') {
      showerror = false;
      Navigator.pushNamed(context, '/homepage');
    } else {
      if (s == 'Wrong Username or Password') {
        setState(() {
          errorIndex = 0;
          showerror = true;
        });
      } else {
        setState(() {
          errorIndex = 1;
          showerror = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blueGrey[100],
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(30.0),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Roll No',
                        hintText: 'Enter your roll no of your child'),
                    onChanged: (rollNo) {
                      _rollNo = rollNo;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your user name',
                  ),
                  onChanged: (userName) {
                    _userName = userName;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                    hintText: 'Enter your password',
                  ),
                  onChanged: (password) {
                    _password = password;
                  },
                ),
              ),
              showerror
                  ? Text(
                      errors[errorIndex],
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : Container(),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    LoginData.updateData(
                      rNo: _rollNo,
                      uName: _userName,
                      pword: _password,
                    );
                    login();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const Text(
                'Don\'t have an account?',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
