import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          child: ClipPath(
              clipper: DiagonalPathClipperTwo(),
              child: Image.asset(
                  'assets/images/andi.png',
                  fit: BoxFit.cover,
                ),
            ),
        ),
        Container(
          padding: EdgeInsets.all(30.0),
          margin: EdgeInsets.only(top: 180.0),
          child: Card(

            elevation: 40.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListTile(
                  title: Text("Catur Andi Pamungkas"),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text("0895358124387"),
                  leading: Icon(Icons.phone),
                ),
                ListTile(
                  title: Text("catur.andi.pamungkas@gmail.com"),
                  leading: Icon(Icons.email),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
