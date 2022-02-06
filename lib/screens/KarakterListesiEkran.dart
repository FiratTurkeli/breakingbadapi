import 'dart:convert';
import 'dart:core';
import 'package:breaking_bad_api/classes/karakterler.dart';
import 'package:breaking_bad_api/screens/KarakterAyr%C4%B1nt%C4%B1Liste.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Karakterler extends StatefulWidget {
  const Karakterler({Key? key}) : super(key: key);

  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {

  List<karakterler> karakterlerListe = <karakterler>[];

  void karakterleriGetir() async {

    Response res = await get(Uri.parse("https://breakingbadapi.com/api/characters"));

    var data = await jsonDecode(res.body);

    setState(() {
      for(var i=0; i<data.length; i++){
        karakterler k = karakterler();
        k.id = data[i]["char_id"];
        k.ad = data[i]["name"];
        k.img = data[i]["img"];

        karakterlerListe.add(k);

      }
    });
  }


  @override
  void initState() {
    super.initState();
    karakterleriGetir();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breaking Bad"),

      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end:  Alignment.bottomLeft,
              colors: [Theme.of(context).backgroundColor, Theme.of(context).scaffoldBackgroundColor],
          tileMode: TileMode.mirror
          )
        ),

       child: ListView.builder(
         itemCount: karakterlerListe.length,
         itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => KarakterAyrinti(id: karakterlerListe[index].id) ));
             },
             child: ListTile(
               title: Text(karakterlerListe[index].ad),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(karakterlerListe[index].img),
                )
             ),
           ) ;
         },

       ),
      )
    );
  }
}
