import 'package:flutter/material.dart';


Widget CardOlusturucu(String leading, String title, BuildContext context){
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    child: ListTile(
      leading: Text(leading),
      title: Text(title),
    ),
  );
}