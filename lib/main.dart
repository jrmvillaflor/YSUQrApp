import 'dart:io';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';


void main() => runApp(MyApp());


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future getAccessToken(String url) async {
  HttpOverrides.global = new MyHttpOverrides();
}

final String url = "https://192.168.10.215/mk/userController";

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YSU APP',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'YSU APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  


class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
  }

  Color gradientStart = Colors.white; 
  Color gradientEnd = Colors.white70;


  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: FractionalOffset(0.9, 0.0),
                end: FractionalOffset(0.0, 0.7),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
                ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Image.asset(
                            'assets/images/ysulogo.png',
                            height: 130),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Contact Tracing App'.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: ButtonTheme(
                          minWidth: 250.0,
                          height: 55.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    color: Colors.red,
                                    onPressed: () async {
                                      final url =
                                          "https://192.168.10.215/mk/adminController";
                                      getAccessToken(url);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()
                                        ),
                                      );
                                    },
                                    child: Text("LOGIN",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'Raleway',
                                        )),
                                    textColor: Colors.white,
                                  ),
                              ),
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  color: Colors.lightGreen,
                                  onPressed: () async {
                                    getAccessToken(url);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()),
                                    );
                                  },
                                  child: Text("SIGNUP",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'Raleway')),
                                  textColor: Colors.white)
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
