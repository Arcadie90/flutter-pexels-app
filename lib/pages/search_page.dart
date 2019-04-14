import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pexels_app/model/pexels.dart';
import 'package:pexels_app/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Pexels pexel;

  Future<void> fetchData(String query, int perPage) async {
    var data = await http.get(ApiProvider.url(query, 1, 20),
        headers: ApiProvider.headers);
    var decoded = jsonDecode(data.body);
    setState(() {
      pexel = Pexels.fromJson(decoded);
    });
  }

  Widget list() {
    return (pexel == null) ? Container(margin: EdgeInsets.only(top: 25.0),child: Center(child: Text('No Image Yet'),)) : ListView.builder(
      itemBuilder: (context, index) {
        final photo = pexel.photos[index];
        return Container(
            padding:
            EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 0),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Column(
                  children: <Widget>[
                    Image.network(photo.src.landscape),
                    Container(
                      width: double.infinity,
                      child: Material(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            photo.photographer,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            ));
      },
      itemCount: pexel.photos.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: "Search"),
                onFieldSubmitted: (query) {
                  fetchData(query, 20);
                },
            ),
            list()
          ],
        ),
      ),
    );
  }
}
