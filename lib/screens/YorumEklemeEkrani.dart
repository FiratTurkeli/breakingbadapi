import 'package:breaking_bad_api/classes/karakterler.dart';
import 'package:breaking_bad_api/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class YorumEkle extends StatefulWidget {
  late karakterler karakter;


  YorumEkle({required this.karakter});

  @override
  _YorumEkleState createState() => _YorumEkleState();
}

class _YorumEkleState extends State<YorumEkle> {

 final db=FirebaseFirestore.instance.collection("karakterler");

 late String yorumText;
 late List<dynamic> yorumList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.karakter.ad, style: TextStyle(fontSize:30),),
            TextField(onChanged: (value){
            yorumText=value;

            },
            decoration: InputDecoration(
                hintText: "Yorum yazınız "
            ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        //await db.doc(widget.karakter.id.toString()).set({"KarakterAd": widget.karakter.ad});
        final belgelerRef = await db.get();

        for(var belge in belgelerRef.docs){
        if (belge.id == widget.karakter.id.toString()) {
          yorumList = belge.data()["yorumlar"];
        }    
        }

        yorumList.add(yorumText);

        await db.doc(widget.karakter.id.toString()).set({"Yorumlar" : yorumList});
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));

        },
      child: Icon(Icons.add),),
    );
  }

}
