import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScannerApp();
  }
}

class ScannerApp extends State<StatefulWidget> {
  final TextEditingController userId = TextEditingController();
  final TextEditingController userRole = TextEditingController();

  checkTextFieldEmptyOrNot() {
    String userIdText, userRoleText;
    userIdText = userId.text;
    userRoleText = userRole.text;
    if (userIdText == "" || userRoleText == "") {
      Fluttertoast.showToast(
          msg: "enter the value",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      print("empty field");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScannerPage(userId.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Center(
          child: Text(
            "Scanner App",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              border: Border.all(color: Colors.green)),
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 7.5),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: userId,
                  decoration: InputDecoration(
                      labelText: "User ID",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 7.5, bottom: 7.5),
                child: TextField(
                  controller: userRole,
                  decoration: InputDecoration(
                      labelText: "User Role",
                      labelStyle: TextStyle(color: Colors.green),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 7.5, bottom: 7.5),
                child: MaterialButton(
                  splashColor: Colors.green,
                  color: Colors.white,
                  onPressed: () {
                    checkTextFieldEmptyOrNot();
                  },
                  child: Text(
                    "click",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
