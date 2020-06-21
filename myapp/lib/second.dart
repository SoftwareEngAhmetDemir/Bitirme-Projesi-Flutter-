import 'package:flutter/material.dart';


import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_icons/flutter_icons.dart';

class second extends StatelessWidget{

void f(BuildContext context)
{
  print('sssss');
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(CommunityMaterialIcons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
         },
    
  ),
     title: Text('BÖLÜM SEÇİNİZ!'),
  ),
      
      drawer: Drawer(
   
    child:
    
    
     ListView(
      
      padding: EdgeInsets.zero,
      children:  <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
            
          ),
          child: Text(
            'KOÜ BİTİRME PROJESİ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(CommunityMaterialIcons.account_circle),
          title: Text('About Me'),
          onTap: ()=> Navigator.pushNamed(context, '/aboutme'),
        ),
        ListTile(
          leading:  Icon(CommunityMaterialIcons.marker_check),
          title: Text('NOTRLAR'),
          onTap: ()=>Navigator.pushNamed(context, '/third'),
        ),
         ListTile(
          leading: Icon(CommunityMaterialIcons.food),
          title: Text('Yemek'),
          onTap: ()=> Navigator.pushNamed(context, '/yemekHane'),
        ),
        ListTile(
         
          leading:  Icon(CommunityMaterialIcons.exit_run),
          title: Text('ÇIKIŞ'),
          onTap: (){ 
          
          showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(Icons.exit_to_app),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
              'Çıkış!!!\n\n\n\n',
  style: TextStyle(fontWeight: FontWeight.bold),
),
              Text('Çıkış yapacağını emin misin?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Evet'),
            onPressed: () {
             Navigator.pushNamed(context, '/');
            },
          ),
///////////////////////////////////////////
 FlatButton(
            child: Text('Hayır'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
////////////////////////////////////////////
        ],
      );
    },
  );
          
          }  
            ),
            // Navigator.pushNamed(context, '/');},
          
        
        
      
      ],
    ),
  ),
      
      
        body: 
        
        Container(
          child: 
       
        Column(
          children: <Widget>[
            SizedBox(height:70,) ,
////

  Center(
    
      child:
      Column(
        children: <Widget>[
 Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),        
          onTap: () {
             Navigator.pushNamed(context, '/third');
          },
          child: Container(            
            width: 350,
            height: 150,
            child:   
            Image.asset('assets/student.jpg', fit: BoxFit.fill)        
          ),
        ),
      ),

//////////////////////////////////
SizedBox(height: 50,),
/////////////////////////////////second Card

 Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
        
          onTap: () {
             Navigator.pushNamed(context, '/yemekHane');
          },
          child: Container(
            
            width: 350,
            height: 150,
            child:   Image.asset('assets/food.jpg', fit: BoxFit.fill),
          ),
        ),
      ),

//////////////////////////////////////////////////
        ],
      )
    ),
///
          ],
        ),
      
      
      decoration: BoxDecoration(
    gradient: new LinearGradient(colors: [Colors.white,Colors.red,Colors.green],
    
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