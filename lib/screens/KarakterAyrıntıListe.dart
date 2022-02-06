import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_api/classes/karakterler.dart';
import 'package:breaking_bad_api/screens/YorumEklemeEkrani.dart';
import 'package:breaking_bad_api/widgets/CardOlusturucu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class KarakterAyrinti extends StatefulWidget {
  final int id;


  KarakterAyrinti({required this.id});

  @override
  _KarakterAyrintiState createState() => _KarakterAyrintiState();
}

class _KarakterAyrintiState extends State<KarakterAyrinti> {

  karakterler k = new karakterler();
  bool yukleniyor = false;

  void karakterGetir() async {

    Response res = await get(Uri.parse("https://breakingbadapi.com/api/characters/${widget.id}"));

    var data = await jsonDecode(res.body);
    setState(() {
      k.ad = data[0]["name"];
      k.img = data[0]["img"];
      k.id = data[0]["char_id"];
      k.oyuncu = data[0]["portrayed"];
      k.takmaAd = data[0]["nickname"];
      k.durum = data[0]["status"];
      yukleniyor = true;
    });
  }

  @override
  void initState() {
    super.initState();
    karakterGetir();

  }
  @override
  Widget build(BuildContext context) {
    return yukleniyor == false ?Scaffold(
      body: Center(
        child:  SpinKitPulse(
          color: Colors.purple, size: 150.0,
        ),
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: TypewriterAnimatedTextKit( text: ["${k.ad}"], textStyle: TextStyle(fontSize: 25.0, fontStyle:FontStyle.italic), speed: Duration(milliseconds: 100),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: NetworkImage(k.img),
              height: 200,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
            width: 150,
            child: Divider(
              color: Colors.lime,

            ),
          ),
          CardOlusturucu("isim", k.ad, context),
          CardOlusturucu("Oyuncu", k.oyuncu, context),
          CardOlusturucu("Takma Ad", k.takmaAd, context),
          CardOlusturucu("Durum", k.durum, context),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => YorumEkle(karakter: k)));
      },
      child: Icon(Icons.comment),),
    );
  }
}
