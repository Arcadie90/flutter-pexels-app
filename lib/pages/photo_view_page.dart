import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {

  final String url;
  final String photographer;

  PhotoViewPage({this.url, this.photographer});

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.photographer),),
        body: Hero(
          tag: widget.url,
          child: PhotoView(
            imageProvider: NetworkImage(widget.url),
            heroTag: widget.url,
          ),
        ),
    );
  }
}