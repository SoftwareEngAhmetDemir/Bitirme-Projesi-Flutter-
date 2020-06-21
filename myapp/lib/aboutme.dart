import 'package:flutter/material.dart';



class aboutme extends StatelessWidget
  
 {
  

  @override
  Widget build(BuildContext context) {
   return  new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Text('About Me'),
        ),


body:

  Container(
     margin: EdgeInsets.only(top: 40,left: 2,right: 2),
    width:MediaQuery.of(context).size.width-2
    ,

decoration: BoxDecoration(
    gradient: new LinearGradient(colors: [Colors.black,Colors.blue,Colors.green],
    
    begin: FractionalOffset.topLeft,
    end:FractionalOffset.bottomRight,
    stops: [0.0,1.0,0],
    tileMode: TileMode.clamp
    ),
      // image: DecorationImage(
      //   image: AssetImage("assets/student.jpg"),
      //   fit: BoxFit.fill,
       
      // ),
    )

    ,
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
                  showDialog(
      context: context,
      builder: (BuildContext context) {
           return   AlertDialog(
          title: new Text("Bitti !!!"),
          content: new Text("Teşekkür ederim ...."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Çıkış"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        },
    );
          },
          child: Container(
            width: 300,
            height: 500,
            child: ListView(
              children: <Widget>[
                Image.network('https://firebasestorage.googleapis.com/v0/b/ogrencisistemi-f1d5f.appspot.com/o/Yemekler%2Ftr_kou.gif?alt=media&token=d9b259cf-b3b3-463f-a31e-d27cc8083c47'),
Flexible(
  child:                   Text('Ahmed Deep Damer \n from syria from the oldest capital in the world and the first ,When i was in syria i passed from alot of challenges like Acm or algorithm data structre ,I have come to turkey before five years ago , but i have not found what i had been waiting in here ',style: TextStyle(fontWeight: FontWeight.bold)),

),

              ],
            ),
          ),
        ),
      ),
    ),



      ),




    );
  }
}