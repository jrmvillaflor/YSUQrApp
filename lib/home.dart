import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'scan.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  final String value;

  HomePage({Key key, @required this.value}) : super(key: key);
}

class HomePageState extends State<HomePage> {
  final String url = "https://192.168.10.215/mk/adminController";

  List userList;
  Map userMap;

  @override
  void initState() {
    super.initState();
  }

  Color appBarColor = Colors.redAccent;

  Color gradientStart = Colors.white;
  Color gradientEnd = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Hello, ${widget.value}!'.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Raleway',
            ),
          ),
          backgroundColor: appBarColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: FractionalOffset(0.9, 0.0),
                end: FractionalOffset(0.0, 0.7),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        buttonColor: Colors.lightGreen,
                        minWidth: 280.0,
                        height: 60.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanPage()),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(MaterialCommunityIcons.qrcode_scan,
                                    color: Colors.white),
                              ),
                              Text(
                                'Scan QR \n '.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Raleway'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
