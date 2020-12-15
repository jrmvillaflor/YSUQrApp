import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'dart:async';
import 'generatescreen.dart';
import 'dart:io';
import 'user.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage();

  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

Future getAccessToken(String url) async {
  HttpOverrides.global = new MyHttpOverrides();
}

final String url = "http://monsterkitchen.000webhostapp.com/mk/userController";

class SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
  }

  final userFNAME = TextEditingController();
  final userADDRESS = TextEditingController();
  final userCONTACTNUMBER = TextEditingController();

  String dummyData;
  TextEditingController qrTextController = TextEditingController();

  final String url = "https://monsterkitchen.000webhostapp.com/mk/userController";

  bool isUpdating = false;
  Map data;
  int id;

  passData() {
    getAccessToken(url);
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) => GeneratePage(
            value: User(
              fullname: userFNAME.text,
              address: userADDRESS.text,
              contactnumber: userCONTACTNUMBER.text,
            ),
          ),
        ))
        .then((_) => formKey.currentState.reset());
  }

  Future<dynamic> adduser() async {
    
    String userfname = userFNAME.text;
    String usercontact = userCONTACTNUMBER.text;
    String useraddr = userADDRESS.text;

    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> adduser = {
      "userFNAME": "$userfname",
      "userADDRESS": "$useraddr",
      "userCONTACTNUMBER": "$usercontact",
    };
    getAccessToken(url);
    final response = await https.post(url, headers: headers, body: adduser);
    int statusCode = response.statusCode;

    print(statusCode);
    print(response);
  }

  void showToastAddSuccess() {
    Fluttertoast.showToast(
        msg: 'Registration Sucessful',
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }

  void showToastAddFailed() {
    Fluttertoast.showToast(
        msg: 'Registration Failed',
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }

  Color gradientStart = Colors.white;
  Color gradientEnd = Colors.white70;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blue,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: FractionalOffset(0.9, 0.0),
                end: FractionalOffset(0.0, 0.7),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/ysulogo.png',
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Text(
                            'Contact Tracing App'.toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Raleway', color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value.isEmpty ? 'Please enter valid Name' : null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 13,
                        ),
                      ),
                      controller: userFNAME,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value.isEmpty ? 'Please enter valid Address' : null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        labelText: "Complete Address",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 13,
                        ),
                      ),
                      controller: userADDRESS,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.length != 11)
                          return 'Mobile Number must be of 11 digit';
                        else
                          return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 13,
                        ),
                      ),
                      controller: userCONTACTNUMBER,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: ButtonTheme(
                      buttonColor: Colors.lightGreen,
                      minWidth: 320.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            getAccessToken(url);
                            passData();
                            adduser();
                            showToastAddSuccess();
                          } else {
                            showToastAddFailed();
                          }
                        },
                        child: Text(
                          'Signup to Generate QR',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
