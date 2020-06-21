
  import 'package:flutter/material.dart';
  import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

  class MyAppYemek extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title: 'Flutter Date Picker Example'),
      );
    }
  }

  class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;
    @override
    _MyHomePageState createState() => new _MyHomePageState();
  }

////////////
class Yemekdetaylari{
String kcal;
String adi;
String resim;
String tatliler;
String day;
Yemekdetaylari(this.kcal,this.adi,this.day,this.resim,this.tatliler);
}

////////////
  class _MyHomePageState extends State<MyHomePage> {


    var finaldate;
 List< Yemekdetaylari> Lyd=[] ;
List<String> L = [];
Yemekdetaylari obj;
@override
  void initState() {
    // TODO: implement initState
setState(() {
  
obj = new Yemekdetaylari("", "Lütfen bir gün seçiniz!!!", "", "","");
    // obj.adi = 'Lütfen bir gün seçiniz!!!';
});

    DatabaseReference ref = FirebaseDatabase.instance.reference().child("yemekhane");


               

ref.once().then((DataSnapshot snap)  {
 


 var Keys = snap.value.keys; // 2019 -Avgsler
 var data = snap.value;


   for(var k in Keys)
  {
    setState(() {
     L.add(data[k]['name']);
   
   
     Lyd .add(   new Yemekdetaylari(snap.value[k]['calories'].toString() 
,snap.value[k]['name'].toString() ,k.toString() , snap.value[k]['resim'].toString() , 
snap.value[k]['tatliler'].toString()));
  });
  
  }

});
 

  
    ////////////////////////
    super.initState();
  }






@override
  


   

    void callDatePicker() async {
      var order = await getDate();
      setState(() {
        finaldate = order;
      //  finaldate =finaldate.toString().substring(8,finaldate.toString().length-12);
      // print(DateFormat('EEEE').format(finaldate));

    finaldate=  DateFormat('EEEE').format(finaldate);

 bool b = false;
for(int i=0;i<Lyd.length;i++)
{
  if(finaldate.toString()==Lyd[i].day)
  {

    // print('ahmeddddddddddddddddddddddddddddddddddddd       *********** '+Lyd[i].adi);
    setState(() {
      
      this.obj = new Yemekdetaylari(Lyd[i].kcal,Lyd[i].adi,Lyd[i].day,Lyd[i].resim,Lyd[i].tatliler);
    });
  b = true;
  }
}
if(!b)
{
  setState(() {
     this.obj = new Yemekdetaylari('','Bugun yemek yok','','','');
  });
   
  print('Bugun yemek yok');
}

      });
    }

    Future<DateTime> getDate() {
      // Imagine that this function is
      // more complex and slow.
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Gün :'+finaldate.toString()+' '+Lyd[0].resim),
        ),
        body: new Center(
          child: new Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Card(
                
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
             showDialog(
      context: context,
      builder: (BuildContext context) {
           return   AlertDialog(
          title: new Text("Yemek Hane !!!"),
          content: new Text("Afiyet Olsun ...."),
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
            width: 320,
            height: 300,
           
            child:
            
             ListView(
               
              children: <Widget>[

                 if(obj.adi!='Lütfen bir gün seçiniz!!!')
                 Container(
                alignment: Alignment.topLeft,
                   child: Column(children: <Widget>[
                    
Text('day : '+obj.day+'\n Yemek : ' + obj.adi+'\n'+'tatliler : '+obj.tatliler + ' \n Clories : '+ obj.kcal+' (kcal)') ,
Image.network(obj.resim),
                   ],)
                 ),
                
               if(obj.adi=='Lütfen bir gün seçiniz!!!')
               Text('Lütfen bir gün seçiniz!!!'),

              ],
            ),
          ),
        ),
              ),


              Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                
              ),
              new FlatButton(
                onPressed:
               callDatePicker,
                // color: Colors.blueAccent,
                child:Icon(Icons.calendar_today)
              ),
            ],
          ),
        ),
      );
    }
  }



