import 'package:digital_escort/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'data.dart';

class Db {
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static Future<String> getKey() async {
    var response = await http.get(
      Uri.parse('https://digitalescort.000webhostapp.com/Keys'),
    );
    return response.body.substring(28, 38);
  }

  static Future<String> register() async {
    var response = await http.post(
        Uri.parse('https://digitalescort.000webhostapp.com/Register'),
        body: {
          "rollno": LoginData.rollNo,
          "username": LoginData.userName,
          "relation": LoginData.relation,
          "email": LoginData.email,
          "cnumber": LoginData.cNumber,
          "password": generateMd5(LoginData.password),
        });
    return response.body;
  }

  static Future<String> login() async {
    var response = await http.post(
        Uri.parse('https://digitalescort.000webhostapp.com/Login'),
        body: {
          "rollno": LoginData.rollNo,
          "username": LoginData.userName,
          "password": generateMd5(LoginData.password),
        });
    return response.body;
  }

  static Future<List<dynamic>> viewlist() async {
    var response = await http
        .post(Uri.parse('https://digitalescort.000webhostapp.com/List'), body: {
      "username": LoginData.userName,
    });
    LoginData.mp[jsonDecode(response.body)[0]["RollNo"]]=jsonDecode(response.body)[0];
    return (jsonDecode(response.body));
  }

  static Future<void> verify() async {
    await http.post(
        Uri.parse('https://digitalescort.000webhostapp.com/verification'),
        body: {
          "rollno": LoginData.rollNo,
        });
  }

  static Future<List<dynamic>> getemail() async {
    var response = await http
        .post(Uri.parse('https://digitalescort.000webhostapp.com/GetEmail'), body: {
      "rollno": LoginData.rollNo,
    });
    // LoginData.mp[jsonDecode(response.body)[0]["RollNo"]]=jsonDecode(response.body)[0];
    return (jsonDecode(response.body));
  }
}
