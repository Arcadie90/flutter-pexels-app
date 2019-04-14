import 'package:flutter/material.dart';
import 'package:pexels_app/model/pexels.dart';
import 'package:pexels_app/pages/search_page.dart';
import 'package:pexels_app/pages/wallpapers_page.dart';
import 'package:pexels_app/provider/api_provider.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: App(),
    title: 'Pexels App',
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  
  CircularBottomNavigationController _navigationController;
  Pexels pexel;
  int pageNo = 1;
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.image, "Wallpapers", Colors.blue),
    new TabItem(Icons.search, "Search", Colors.blue),
  ]);

  @override
  void initState() {
    super.initState();
    fetchData("wallpaper",20);
  
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  incPage(){  
    setState(() {
      pageNo++;
    });
  }

  Future<void> fetchData(String query, int perPage) async {
    var data = await http.get(ApiProvider.url("wallpaper", pageNo, 20), headers: ApiProvider.headers);
    var decoded = jsonDecode(data.body);
    incPage();
    setState((){
      pexel = Pexels.fromJson(decoded);
    });
  }

  Widget bodyContainer() {
    switch (selectedPos) {
      case 0:
        return WallpapersPage(pexel, fetchData);
      case 1:
        return SearchPage();
       
      default:
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pexels App'),
        elevation: 12.0,
      ),
      body: (pexel == null)
          ? LinearProgressIndicator() : bodyContainer(),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barBackgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int selectedPos) {
          setState(() {
            this.selectedPos = selectedPos;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
