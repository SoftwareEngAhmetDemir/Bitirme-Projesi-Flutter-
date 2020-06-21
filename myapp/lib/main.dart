
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/third.dart';
import 'package:myapp/second.dart';
import 'package:myapp/yemekHane.dart';
import 'package:myapp/aboutme.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:loading_animations/loading_animations.dart';

void main() {
  
  runApp(MaterialApp(
    // home: MyApp2(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
     '/': (BuildContext context) => MyApp2(),
      '/second': (BuildContext context) => second(),
      '/third': (BuildContext context) => third2(),
      '/yemekHane': (BuildContext context) => MyAppYemek(),
      '/aboutme': (BuildContext context) => aboutme(),
      
    },
  ));
}
class Ogrenciler
{
  String id;
  String pass;
  
Ogrenciler(this.pass,this.id);
}

class MyApp2 extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return MyApp();
  }
  
}

class MyApp extends State<MyApp2> {
  static String id='';
List<Ogrenciler> L = [];
String textnumber='';
String password='';



@override
  void initState() {
   LoadingFlipping.circle(
  borderColor: Colors.cyan,
  borderSize: 3.0,
  size: 30.0,
  backgroundColor: Colors.cyanAccent,
  duration: Duration(milliseconds: 500),
);
    super.initState();
  }


 void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Bittirme Projesi 2020"),
          content: new Text("Hoş geldiniz !!! Bu Uygulama Google tarafından geliştirilmiş Flutter FrameWorku Kullanarak Programlandı  "),
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text('Giriş Sayfası'),
         
       ),
       body:
       
       Container(
 
 
 
         child:
       
       Center(child:ListView(
         
  padding: const EdgeInsets.all(8),
         children: <Widget>[
        Container(
          width: 100,
          height: 100,
 
        ),
        
    SizedBox(height: 50.0),
    Container(

   width: 350,
   margin: EdgeInsets.only(left:20,right: 30),
  // color: Colors.amber, 

 child:TextField(
  
  
  
  obscureText: false,
  keyboardType: TextInputType.number,
  //Cursor color change
 
  
  onChanged: (value) {
    setState(() {
      this.textnumber = value;
    });
  },
  
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Öğrenci Numarası',
    hintText: "Öğrenci Numarası",
              //add icon outside input field
               prefixIcon: Icon(Icons.person),
    suffixIcon: Icon(Icons.text_format),
     
  ),
),
 ),
//  Text(L[1].pass+' '+L[2].id),
 
SizedBox(height: 50.0),
// Text(textnumber),
// Text(password),
//SizedBox(height:50.0,),
Container(
  width:350,
  margin: EdgeInsets.only(left:20,right: 30),
child:TextField(
  obscureText: true,
  onChanged: (value) {
    setState(() {
      this.password = value;
     
    });
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Şifre',
    hintText: "Şifre",
              //add icon outside input field
               prefixIcon: Icon(Icons.enhanced_encryption),
    suffixIcon: Icon(Icons.camera),
     
  ),
)
  ),
   SizedBox(height: 40,),
    
    Container(

   width: MediaQuery.of(context).size.width / 2,
  height: 50,
  margin: EdgeInsets.only(left:60,right: 60),
    child:FlatButton(
      
    
            onPressed: () 
             {
              DatabaseReference ref = FirebaseDatabase.instance.reference().child("Ogrenciler/${textnumber}");
 bool b = false;

             ref.once().then((DataSnapshot snap)   {
                print('printtttttttttttttttttttttttttttttttttttttttttttttttttt');
                setState(() {
                  b=true;
                });
                
                   
                 
                
                   
                    if(snap.value['pass']==this.password){
                       MyApp.id = textnumber;
                      Navigator.pushNamed(context, '/second');
                    }
                   
           else
           {

             showDialog(
      context: context,
      builder: (BuildContext context) {
           return   AlertDialog(
          title: new Icon(Icons.warning),
          content: new Text("şifre yada numra yanlıştır!!!! "),
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
           }     
              
               
               }).then((value) => null).catchError((onError){

showDialog(
      context: context,
      builder: (BuildContext context) {
           return   AlertDialog(
          title: new Icon(Icons.warning),
          content: new Text("şifre yada numra yanlıştır!!!! "),
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
         
               });
               
       
                       
                   
         
          
            },

  

            textColor: Colors.red,
          
            // padding: const EdgeInsets.all(0.0),
            child: Container(
    width: 50,       
              // padding: const EdgeInsets.all(10.0),
              child:
                  // const Text('Giriş', style: TextStyle(fontSize: 20)),
                  Icon(Icons.verified_user)
            ),
     color: Colors.cyan,

shape: CircleBorder(),
               
              

    ),




     ),



     
 //Navigate to the second Page
Container(
  margin: EdgeInsets.all(150,),


  child:FlatButton(onPressed: (){
    
      _showDialog();
     
  }, child: Icon(CommunityMaterialIcons.account_badge))),
  ],
    
                ),         //  Text('ahmed'),
  ),

  // color: Colors.white,
 
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
    ),
 
     ),  
     ),
  );
}
}