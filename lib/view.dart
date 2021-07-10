import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class View extends StatelessWidget {
  @override
  String authorName, des, title, imageURL;
  View(
      {@required this.imageURL,
      @required this.authorName,
      @required this.title,
      @required this.des});
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "view",
          ),
        ),
        body: Container(
            child: Container(
                margin: EdgeInsets.only(top: 16),
                height: 900,
                color: Colors.white30,
                child: Stack(children: [
                  ClipRect(
                    child: CachedNetworkImage(
                      imageUrl: imageURL,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  ),
                  Container(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Title :$title",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description :$des",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Author :$authorName",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )))
                ]))));
  }
}
