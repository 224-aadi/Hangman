import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading.dart';
import 'main.dart';

class game extends StatefulWidget{
  final int gamescore;
  final String words;

  game({this.words, this.gamescore});

  @override
  State<StatefulWidget> createState() {
    return _game();
  }
}

class _game extends State<game>{


  String word;
  List wordArr = [];
  List wordArr2 = [];
  List green = [];
  List red = [];
  List Noclick = [];
  int wrong = 0;
  SharedPreferences prefs;
  int score;
  int tap = 0;
  int k = 0;
  int score2;


  @override
  void initState() {
    score2 = widget.gamescore;
    word = widget.words;
    getPrefs();
    wordArr = word.split('');
    for(int i = 0; i<wordArr.length; i++){
      wordArr2.add('_');
    }
    print('wordArr');
    print(wordArr);
    print('wordArr2');
    print(wordArr2);
    super.initState();
  }

  onPress(String value){
    if(Noclick.contains(value)){
      return false;
    }else{
      return true;
    }
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    score = prefs.getInt('score') ?? 0;
    print(score);
  }

  checkLetter(String value) {
    tap = tap+1;
    if(wrong<6 ){
      int flag = 0;
      for(int i = 0; i<wordArr.length; i++){
        if(wordArr[i].toString().toUpperCase() == value){
          setState(() {
            wordArr2[i] = wordArr[i];
            Noclick.add(value);
            green.add(value);
            flag = 1;
          });
        }
      }
      if(flag == 0){
        setState(() {
          red.add(value);
          Noclick.add(value);
          wrong = wrong + 1;
          print(wrong);
        });
      }
      check();
    }
  }

  check(){
    if(listEquals(wordArr, wordArr2)){
      print('DONE');
      showAlertComplete(context);
    }else if(wrong == 6){
      print('WONGG');
      showAlertWrong(context);
    }
  }

  showAlertComplete(BuildContext context) {
    AssetImage assetImage0 = AssetImage('images/complete.png');
    Image imageComplete = Image(image: assetImage0, width: 50,);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loading(score: widget.gamescore+1,)));
        });
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            backgroundColor: Colors.black54,
            title: Container(
              child: imageComplete,
            ),
          content: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(word.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 17),),
            )
          ],
        )
        );
      },
    );
  }

  showAlertWrong(BuildContext context) {
    AssetImage assetImage0 = AssetImage('images/wrong.png');
    Image imageComplete = Image(image: assetImage0, width: 50,);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), (){
          if(widget.gamescore > score){
            prefs.setInt('score', widget.gamescore);
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
        });
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            backgroundColor: Colors.black54,
            title: Container(
              child: imageComplete,
            ),
          content: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(word.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 17),),
              )
            ],
          )
        );
      },
    );
  }

  Widget button(String value, double d){
    return RawMaterialButton(
      constraints: BoxConstraints(),
      onPressed: onPress(value)
          ? () => checkLetter(value)
          : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: (green.contains(value)) ?
      Colors.green
          :
      (red.contains(value)) ?
      Colors.redAccent
          :
      Colors.blue,
      padding: EdgeInsets.all(d),
      child: Text(value, style: TextStyle(fontWeight: FontWeight.bold),),
      shape: CircleBorder(),
    );
  }
  Widget KeyBoard(){
    return Expanded(
        flex: 0,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  button('Q', 10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('W', 8),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('E',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('R',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('T',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('Y',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('U',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('I',12),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('O',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('P',10),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  button('A',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('S',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('D',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('F',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('G',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('H',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('J',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('K',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('L',10),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  button('Z',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('X',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('C',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('V',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('B',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('N',10),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  button('M',10),
                ],
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage0 = AssetImage('images/hangman-0.png');
    Image image0 = Image(image: assetImage0, width: 100,);

    AssetImage assetImage1 = AssetImage('images/hangman-1.png');
    Image image1 = Image(image: assetImage1, width: 100,);

    AssetImage assetImage2 = AssetImage('images/hangman-2.png');
    Image image2 = Image(image: assetImage2, width: 100,);

    AssetImage assetImage3 = AssetImage('images/hangman-3.png');
    Image image3 = Image(image: assetImage3, width: 100,);

    AssetImage assetImage4 = AssetImage('images/hangman-4.png');
    Image image4 = Image(image: assetImage4, width: 100,);

    AssetImage assetImage5 = AssetImage('images/hangman-5.png');
    Image image5 = Image(image: assetImage5, width: 100,);

    AssetImage assetImage6 = AssetImage('images/hangman-6.png');
    Image image6 = Image(image: assetImage6, width: 100,);
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 44)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: IconButton(
                      icon: Icon(Icons.home, size: 35,),
                      onPressed: (){
                        if(widget.gamescore > score){
                          prefs.setInt('score', widget.gamescore);
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(right: 25),
                  child: Text('Score:  $score2', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              child: (wrong == 0)?
              image0
                  :
              (wrong == 1)?
              image1
                  :
              (wrong == 2)?
              image2
                  :
              (wrong == 3)?
              image3
                  :
              (wrong == 4)?
              image4
                  :
              (wrong == 5)?
              image5
                  :
              image6,
            ),
            Padding(padding: EdgeInsets.only(top: 50)),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              children: <Widget>[
                for(var i in wordArr2) Text(i.toString().toUpperCase(), style: TextStyle(fontSize: 50),)
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 150)),

            KeyBoard(),
          ],
        ),
      ),
    );
  }
}