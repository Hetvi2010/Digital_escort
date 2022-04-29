import 'package:digital_escort/data.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'dart:convert';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Passwordverify extends StatefulWidget {
  const Passwordverify({Key? key}) : super(key: key);

  @override
  State<Passwordverify> createState() => _PasswordverifyState();
}

class _PasswordverifyState extends State<Passwordverify> {
  String _rollNo = '';
  String _userName = '';
  String _password = '';
  List<String> errors = [
    'Wrong Password',
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
      await Db.verify();
      List<dynamic> mailList = await Db.getemail();
      print(mailList);
      final Email email = Email(
        body: 'Email body',
        subject: 'Email subject',
        recipients: mailList.map((e) => e["email"].toString()).toList(),
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
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
      body: Container(
        child: AlertDialog(
          title: const Center(
            child: Text('Verify user'),
          ),
          content: SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Column(
                children: [
                  LoginData.mp[LoginData.rollNo]["Image_url"] == ""
                      ? Container()
                      : Image.network(
                          LoginData.mp[LoginData.rollNo]["Image_url"],
                          width: 100,
                          height: 100,
                        ),
                  TextField(
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
                        icon: Icon(isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: 'Enter your password',
                    ),
                    onChanged: (password) {
                      _password = password;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                login();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
