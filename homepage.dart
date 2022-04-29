import 'package:digital_escort/data.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget getContainer(String text, Function fn) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          fn();
        },
        child: Container(
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.indigo.shade200,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LoginData.userName),
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    // child: ColorPicker(
                    //   pickerColor: pickerColor,
                    //   onColorChanged: changeColor,
                    // ),
                    child: MaterialPicker(
                      pickerColor: pickerColor,
                      onColorChanged: changeColor,
                    ),
                    // child: BlockPicker(
                    //   pickerColor: currentColor,
                    //   onColorChanged: changeColor,
                    // ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        setState(() => currentColor = pickerColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentColor,
                    border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: Colors.black,
                    )),
              ),
            )
          ],
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          getContainer(
            'QR CODE',
            () async {
              String key = await Db.getKey();
              var digest = sha256.convert(utf8.encode(LoginData.rollNo + key));
              var digest2 =
                  sha256.convert(utf8.encode(LoginData.userName + key));
              return showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Center(
                    child: Text('QR Code'),
                  ),
                  content: SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: QrImage(
                        data: digest.toString() +
                            digest2.toString() +
                            " " +
                            LoginData.rollNo +
                            " " +
                            LoginData.userName,
                        version: QrVersions.auto,
                        size: 200,
                        foregroundColor: currentColor,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          getContainer('HISTORY', () {}),
          getContainer('VERIFY', () {
            Navigator.pushNamed(context, '/view');
          }),
          getContainer('STUDENT INFO', () {}),
        ],
      ),
    );
  }
}
