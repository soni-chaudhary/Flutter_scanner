import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:http/http.dart' as http;

class ScannerPage extends StatelessWidget {
  late String id;
  ScannerPage(String id) {
    this.id = id;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR/Bar Code Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(id: id),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.id});
  final String id;
P
  @override
  _MyScannerPageState createState() => _MyScannerPageState();
}

class _MyScannerPageState extends State<MyHomePage> {
  late String name = "";
  late String userRole = "Customer";

  Future PostData(String id, String role, String name, String qrCode) async {
    try {
      final url =
          Uri.parse("https://scanner-data-api.herokuapp.com/api/scanner");
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "id": id,
        "role": role,
        "name": name,
        "qr_code": qrCode
      };
      String jsonBody = jsonEncode(body);
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.post(url,
          headers: headers, body: jsonBody, encoding: encoding);

      int statuseCode = response.statusCode;
      String responseBody = response.body;
      print(statuseCode);
      print(responseBody);

      //  print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      print(e);
    }
  }

  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scaneer"),
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 400,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightGreenAccent,
                ),
                height: 400,
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Text(
                        _qrInfo!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Name => ${name}",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "UserRole => ${userRole}",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "UserID => ${widget.id}",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        splashColor: Colors.green,
                        color: Colors.white,
                        child: Text(
                          "click",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          await PostData(
                              "${widget.id}", userRole, name, _qrInfo!);
                          // await postApi(
                          //     "${widget.id}", name, userRole, _qrInfo!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
