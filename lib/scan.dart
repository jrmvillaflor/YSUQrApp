import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as https;

class ScanPage extends StatefulWidget {
  @override
  ScanPageState createState() => ScanPageState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

back(BuildContext context) {
  Navigator.pop(context);
}

Future getAccessToken(String url) async {
  HttpOverrides.global = new MyHttpOverrides();
}

class ScanPageState extends State<ScanPage> {
  final String url = "https://monsterkitchen.000webhostapp.com/mk/userLoginController";
  final String url2 = "https://monsterkitchen.000webhostapp.com/mk/adminController";

  var dropdownValue;
  List userList;
  Map userMap;
  final temperature = TextEditingController();

  getAllDatas() async {
    getAccessToken(url);

    final response = await https.get(url2);

    userMap = json.decode(response.body);
    userList = userMap.values.toList();
  }

  @override
  void initState() {
    super.initState();
    getAllDatas();
    getAccessToken(url);
  }

  Future<dynamic> adduser() async {
    getAccessToken(url);

    String formattedDate = DateFormat.yMd().add_jm().format(now);
    String userfname = qrCodeResult;
    String timein = formattedDate;
    String branch = 'YSU - IGPIT';
    String temp = temperature.text + "°C";

    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> adduser = {
      "userFNAME": "$userfname",
      "timein": "$timein",
      "branch": "$branch",
      "temperature": "$temp",
    };

    final response = await https.post(url, headers: headers, body: adduser);
    int statusCode = response.statusCode;

    print(statusCode);
    print(response);

    showToastAddSuccess();
  }

  void showToastAddSuccess() {
    Fluttertoast.showToast(
        msg: 'Sucessfully Added',
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
    back(context);
  }

  bool isUpdating = false;
  Map data;
  int id;
  DateTime now = DateTime.now();

  String qrCodeResult;
  bool backCamera = true;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd().add_jm().format(now);

    Color appBarColor = Colors.redAccent;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text(
            "Scan using:" + (backCamera ? "Front Cam" : "Back Cam"),
            style: TextStyle(fontSize: 15, fontFamily: 'Raleway'),
          ),
          actions: <Widget>[
            IconButton(
              icon: backCamera
                  ? Icon(Ionicons.ios_reverse_camera)
                  : Icon(Icons.camera),
              onPressed: () {
                setState(() {
                  backCamera = !backCamera;
                  camera = backCamera ? 1 : -1;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                  child: Text(
                    (qrCodeResult == null) || (qrCodeResult == "")
                        ? "Please Scan to show some result".toUpperCase()
                        : "Time In: $formattedDate \n name: ".toUpperCase() +
                            qrCodeResult.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Raleway',
                      wordSpacing: 5,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
                    child: Column(
                      children: <Widget>[
                        (qrCodeResult == null) || (qrCodeResult == "")
                            ? Text('')
                            : Text(
                                'BRANCH: YSU - Igpit'.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(80, 0, 80, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (qrCodeResult == null) || (qrCodeResult == "")
                            ? Text('')
                            : TextFormField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller: temperature,
                                decoration: InputDecoration(
                                hintText: "Temperature".toUpperCase(),                              
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 12,
                                  color: Colors.grey
                                ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: ButtonTheme(
                    buttonColor: Colors.lightGreen,
                    minWidth: 150.0,
                    height: 50.0,
                    child: Column(
                      children: <Widget>[
                        (qrCodeResult == null) || (qrCodeResult == "")
                            ? Text('')
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                onPressed: () async {
                                  adduser();
                                },
                                child: Text(
                                  'Enter',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                        Container(
                          child: ButtonTheme(
                            buttonColor: Color.fromARGB(500, 4, 183, 226),
                            minWidth: 150.0,
                            height: 50.0,
                            child: Column(
                              children: <Widget>[
                                (qrCodeResult == null) || (qrCodeResult == "")
                                    ? IconButton(
                                        iconSize: 60,
                                        icon: Icon(
                                            MaterialCommunityIcons.qrcode_scan),
                                        color: Colors.black,
                                        onPressed: () {
                                          _scan();
                                        },
                                      )
                                    : Text('')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _scan() async {
    ScanResult codeSanner = await BarcodeScanner.scan(
      options: ScanOptions(
        useCamera: camera,
      ),
    );
    setState(() {
      qrCodeResult = codeSanner.rawContent;
    });
  }
}

int camera = 1;
