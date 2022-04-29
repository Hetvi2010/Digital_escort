import 'dart:convert';
import 'package:flutter/material.dart';
import 'data.dart';
import 'database.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String _rollNo;
  late String _userName;
  late String _password;
  late String _email;
  late String _cNumber;
  bool isObscure = true;
  List<String> relation = [
    'Choose your relation',
    'Mother',
    'Father',
    'Grand Father',
    'Grand Mother'
  ];
  String dropdownValue = 'Choose your relation';

  bool showerror = false;
  List<String> errors = [
    'username already exist',
    'server might be busy please try after some time',
  ];
  int errorIndex = 0;

  void register() async {
    String s = await Db.register();
    // print(s);
    // if (s[0] != '{') {
    //   setState(() {
    //     showerror = true;
    //     errorIndex = 1;
    //   });
    //   return;
    // }
    s = jsonDecode(s);
    if (s == 'Registered Successfully') {
      showerror = false;
      Navigator.pushNamed(context, '/homepage');
    } else {
      if (s == 'username already exist') {
        setState(() {
          errorIndex = 0;
          showerror = true;
        });
      } else {
        setState(() {
          showerror = true;
          errorIndex = 1;
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
              Container(
                margin: const EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: dropdownValue,
                  icon: const SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: relation.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  // obscureText: true,
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
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Id',
                        hintText: 'Enter a valid Email Id'),
                    onChanged: (email) {
                      _email = email;
                    }
                    
                    ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile No',
                        hintText: 'Enter a valid contact number'),
                    onChanged: (cnum) {
                      _cNumber = cnum;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
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
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    LoginData.updateData(
                      rNo: _rollNo,
                      uName: _userName,
                      rel: dropdownValue,
                      pword: _password,
                      mail: _email,
                      cnum: _cNumber,
                    );
                    register();
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
