import 'package:flutter/material.dart';
import 'package:pexels_app/model/pexels.dart';
import 'package:pexels_app/pages/photo_view_page.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class WallpapersPage extends StatefulWidget {
  final Pexels pexel;
  final Function(String, int) fetchData;
  WallpapersPage(this.pexel, this.fetchData);

  @override
  _WallpapersPageState createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: LiquidPullToRefresh(
        onRefresh: () {
          return widget.fetchData("wallpaper", 20);
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            final photo = widget.pexel.photos[index];
            return Container(
                padding: EdgeInsets.only(
                    top: 10.0, right: 10.0, left: 10.0, bottom: 0),
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag: photo.src.original,
                            child: GestureDetector(
                              child: Image.network(photo.src.landscape),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PhotoViewPage(
                                          url: photo.src.original,
                                          photographer: photo.photographer,
                                        )));
                              },
                            ),
                          ),
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
          itemCount: widget.pexel.photos.length,
        ),
      ),
    );
  }
}
