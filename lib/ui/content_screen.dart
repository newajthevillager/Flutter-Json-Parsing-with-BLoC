import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  String headline;
  String imageUrl;
  String time;
  String content;

  ContentScreen({this.headline, this.imageUrl, this.time, this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cricket"),
      ),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Image.network(imageUrl),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              headline,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(time),
          ),
          Text(content),
        ],
      ),
    );
  }
}