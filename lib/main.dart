import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hangman/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int score = 0;
  SharedPreferences prefs;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }
  
  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('score') ?? 0;
    });
    print(score);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 44)),
            Center(
              child: Text('HANGMAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,
                  color: Colors.white),),
            ),
            Padding(padding: EdgeInsets.only(top: 120)),
            Image.asset(
                'images/hangman_pic.gif',
              width: 250,
            ),
            Padding(padding: EdgeInsets.only(top: 120)),
            RaisedButton(
              onPressed: (){
                var _score = 0;
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => loading(score: _score)));
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text('START', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),

            Text('HIGH SCORE:  $score', style: TextStyle(fontSize: 20, color: Colors.white),)
          ],
        ),
      ),
    );
  }
  
}
