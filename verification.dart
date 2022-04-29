import 'dart:ui';

import 'package:flutter/material.dart';
import 'database.dart';

class VerifyRequest extends StatefulWidget {
  const VerifyRequest({Key? key}) : super(key: key);

  @override
  State<VerifyRequest> createState() => _VerifyRequestState();
}

class _VerifyRequestState extends State<VerifyRequest> {
  late List<dynamic> kaibi;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    show();
  }

  void show() async {
    kaibi = await Db.viewlist();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Requests'),
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: kaibi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    color: Colors.indigo.shade200,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Roll No:' + kaibi[index]["RollNo"].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        kaibi[index]["isVerified"] == "true"
                            ? const Text(
                                'Verified',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            : TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/pverify');
                                },
                                child: const Text('Verify')),
                      ],
                    ),
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
