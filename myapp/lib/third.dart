import 'package:flutter/material.dart';

import 'package:myapp/main.dart';
import 'package:firebase_database/firebase_database.dart';

class Dersler
{
String Harf;
String Kredi;
String Ders;
Dersler(this.Ders,this.Harf,this.Kredi);
}


class third2 extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() {
    return third();
  }
  
}

class MyPainter extends CustomPainter{
  
  @override
  void paint(Canvas  canvas, Size size) {
    final left = 60.0;
  final top = 40.0;
  final right = 300.0;
  final bottom = -10.0;
  final rect = Rect.fromLTRB(left, top, right, bottom);
  final paint = Paint()
    ..color = Colors.amber
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;
  canvas.drawRect(rect, paint);
    }
  
    @override
    bool shouldRepaint(CustomPainter  canvas) {
 
    return false;
  }

}
class third extends State<third2>{
 static String Genel_Ortalama='';
 static String Toplam_Kredi = '';

  static List<String> pass=[];
  static List<Dersler>dersler=[];
  static String ogretim = '';
  double ort = 0.0;
  ///////////////////////////
  
  
  ////////////////////////
   String get_Numara()
  { 
    return MyApp.id;
  }
  String get_Ogretim()
  {
    
    if(this.get_Numara()[5]=='1')
    {
      return "IOgretim";
    }
    else
    return "IIOgretim";
  }
  @override
  void initState() {
    setState(() {
      this.get_Numara() ;  
      third.ogretim = this.get_Ogretim();
    });
Toplam_Kredi = '';
    third.dersler=[];
  DatabaseReference ref = FirebaseDatabase.instance.reference().child("Siciller");
ref.once().then((DataSnapshot snap)  {
 
var Keys;
var data;
setState(() {
   Keys = snap.value.keys; // 2019 -Avgsler
  data = snap.value;
});
 


  for(var k in Keys)
  {
    if(k.toString()!='Avgsler') // get  years like 2019-2020 ...etc. 
    {
//third.pass.add(k.toString());

 DatabaseReference ref2 = FirebaseDatabase.instance.reference().child("Siciller/${k.toString()}");
 ref2.once().then((DataSnapshot snap2)  {
var kdonem;
setState(() {
  kdonem = snap2.value.keys; // Bahar , GUZ 
});
 
//third.pass.add(kdonem.toString()); //BAHAR , Guz

// third.pass.add("Siciller/${k.toString()}/${kdonem}/${this.get_Ogretim()}/${this.get_Numara()}");
for(var kd in kdonem){ // separate json for Semesters (Guz,Bahar) ===> [0]=Guz , [1]= Bahar
  // third.pass.add(kd.toString());
// print('Donemlerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr '+kd.toString());


DatabaseReference ref3;

  ref3 = FirebaseDatabase.instance.reference()
.child("Siciller/${k.toString()}/${kd}/${this.get_Ogretim()}/${this.get_Numara()}");

 

third.pass.add(this.get_Ogretim());
ref3.once().then((DataSnapshot snap3) {
var kdonemdetails;
var data;
setState(() {
  kdonemdetails = snap3.value.keys;// donem iceregi detaylar
//third.pass.add(kdetails.toString()); // (Average,algo22,algo) in json type
 data = snap3.value;
});
 
// for(var kddd in kdonemdetails)
// {  if(kddd.toString()!='Average')
//    setState(() {
//        if(data[kddd]['Harf']!=null|| data[kddd]['Harf'].toString()!="")
// ort+= data[kddd]['Kredi']*data[kddd]['Harf_etkisi'];
     
//      });
// }

for(var kdd in kdonemdetails) // [0]=Average, [1] = Algo , [2] = Algo22 ...
{
 
  if(kdd.toString()!='Average'){
    // ort+= int.parse(data[kdd]['Kredi'])* double.parse(data[kdd]['Harf_etkisi']);
 Dersler d ;
 // yeni bir ders alinmis ise o zaman vize ve final olmayacak
setState(() {
   if(data[kdd]['Final']=="" ){
   d = new Dersler(kdd.toString(), "X", data[kdd]['kredi'].toString());
   }
});
 
  //if(data[kdd]['kredi'].toString()=="")
// d = new Dersler(kdd.toString(), "-", data[kdd]['Kredi'].toString());
  
  setState(() {
     if(data[kdd]['Final']!="" )
    d = new Dersler(kdd.toString(), data[kdd]['Harf'].toString(),
      data[kdd]['Kredi'].toString());
  });
       
  
  
  
     setState(() {
third.dersler.add(d);
 print('etkisi '+ data[kdd]['Harf_etkisi'].toString());

 var r = data[kdd]['Harf_etkisi'].toString();
 if(r!='')
 if(data[kdd]['Kredi'].toString()=='')
 ort+=0;
 else
 ort+= int.parse(data[kdd]['Kredi'])*double.parse(r);
     });
    
     
     
  
 

  }

}

} );
}
 });


    }


  }


});
/////////////////////////Genel Ortalama Almak ///////////////////////
DatabaseReference refo;
var keyso;
var datao;

  

 refo = FirebaseDatabase.instance.reference().
child("Siciller/Avgsler/${this.get_Ogretim()}/${this.get_Numara()}");

refo.once().then((DataSnapshot ds){
setState(() {
  

  keyso = ds.value.keys;
 datao = ds.value;
});
if(datao!=null){
setState(() {
  // third.Genel_Ortalama = data['Genel_Ort'].toString();
  third.Toplam_Kredi = datao['kredi'].toString();
  if(datao['kredi'].toString()!='')
ort = ort/int.parse(datao['kredi']);
else
ort = 0;
});
}
}).catchError((onError)=>{

});

  super.initState();
  
  }

  List<DataRow> get_tb()
  {List<DataRow> L =[];
  for(var i in dersler){
    setState(() {
      
    
  L.add(
    
    
     DataRow(
      
          cells: <DataCell>[
             DataCell(Text(i.Ders)),
            DataCell(Text(i.Kredi)),
            DataCell(Text(i.Harf)),
            
          ],
        ));
      

  }
  );
  }



      
         

  return L;   
  }
   
  @override
  Widget build(BuildContext context) {
    var container = Container(
  child:Column(children: <Widget>[


  

if(third.Toplam_Kredi.toString()!='')
if(double.parse(third.Toplam_Kredi)!=0)
Text('Ortalama : '+ ((((this.ort/double.parse(third.Toplam_Kredi))*100).round())/100).toString()+
 ' \n Toplam Kredi:'+third.Toplam_Kredi, textAlign: TextAlign.center, 


 style: TextStyle(fontWeight: FontWeight.bold , color: Colors.red),
 
 ),
 if(third.Toplam_Kredi.toString()=='')
 Text('Ortalama : '+ '--- '+
 ' \n Toplam Kredi: '+'---', textAlign: TextAlign.center, 


 style: TextStyle(fontWeight: FontWeight.bold , color: Colors.red),
 
 ),
 ],)
 );
    return MaterialApp(
home:Scaffold(
appBar: AppBar(
  title:Text(this.get_Numara()+'  / ' + third.ogretim) ,
),
body:

Container(
  child:


ListView(
  // This next line does the trick.
 scrollDirection: Axis.vertical,
  children: <Widget>[
   


// for(int i=0;i<third.dersler.length;i++)
// Text('pass ===>'+third.dersler[i].Final),


/////////////////////////table

Container(
      // height: MediaQuery.of(context).size.height,
      // width:MediaQuery.of(context).size.width,
decoration: BoxDecoration(
    gradient: new LinearGradient(colors: [Colors.white,Colors.blue,Colors.green],
    
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

 child:Expanded(child:DataTable(
   
      columns: const <DataColumn>[
        
        DataColumn(
          
          label: Text(
            'Ders',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          
          label: Text(
            'Kredi',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
       
        
         DataColumn(
          label: Text(
            'Harf',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
     
      rows: List.generate(third.dersler.length, (index) =>  get_tb()[index]),
      
    ),
    
 ),
),         
      


/////////////////////////////////////
 SizedBox(height:30),
Container(
  margin: EdgeInsets.only(top:3),
  
 
 
),
 CustomPaint(
size: Size(20, 20),

child:container,
painter: MyPainter(),

 ),
 
 
  ],
  
),


decoration: BoxDecoration(
    gradient: new LinearGradient(colors: [Colors.amber,Colors.blue,Colors.green],
    
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