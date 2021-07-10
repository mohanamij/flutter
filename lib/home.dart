import 'package:blog_app/services/crud.dart';
import 'package:blog_app/upload.dart';
import 'package:blog_app/view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudMethods crudmethods = new CrudMethods();
  Stream blogsStream;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> allBlogsList = [];

  Widget Bloglist() {
    return Container(
      child: blogsStream != null
          ? StreamBuilder(
              stream: blogsStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  //Okay na??Yes man ! ek aur dekh
                  //
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageURL:
                                snapshot.data.docs[index].data()["imageURL"] ??
                                    "",
                            authorName:
                                snapshot.data.docs[index].data()['author'] ??
                                    "",
                            title:
                                snapshot.data.docs[index].data()['title'] ?? "",
                            des: snapshot.data.docs[index].data()['des'] ?? "",
                            id: snapshot.data.docs[index].data()["id"] ?? "");
                      });
                }
              })
          : Container(
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudmethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    crudmethods.getAllDocumentsOfBlogs().then((value) {
      for (var item in value.docs) {
        setState(() {
          allBlogsList.add(item.data());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String searchval;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BlogApp",
              style: TextStyle(fontSize: 20, color: Colors.amber),
            ),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      body: Bloglist(),

      //  Column(
      //   children: [
      //     TextField(
      //       decoration: InputDecoration(
      //         hintText: "Search",
      //         hintStyle: TextStyle(fontSize: 18),
      //       ),
      //       onChanged: (val) async {
      //         searchval = val;
      //         for (var item in allBlogsList) {
      //           debugPrint("item :$item");
      //           if (item['title'].toString().contains(val)) {
      //             if (!data.contains(item))
      //               setState(() {
      //                 data.add(item);
      //               });
      //             // break;
      //           } else {
      //             // setState((){})
      //           }
      //         }
      //       },
      //     ),
      //     SizedBox(height: 10),
      //     data.length == 0
      //         ? Bloglist()
      //         : Container(
      //             child: Column(
      //                 children: data.map((e) => Text(e['title'])).toList())),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Upload()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      
      
    );
  }
}

class BlogTile extends StatelessWidget {
  String authorName, des, title, imageURL, id;
  CrudMethods crudmethods = new CrudMethods();
  BlogTile(
      {@required this.imageURL,
      @required this.authorName,
      @required this.id,
      @required this.title,
      @required this.des});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 16),
              height: 250,
              child: Stack(
                children: [
                  ClipRect(
                    child: CachedNetworkImage(
                      imageUrl: imageURL,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.black45.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            des,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            authorName,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                                fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {
                              crudmethods.deleteUser(id);
                            },
                            child: Text("Delete"),
                            color: Colors.redAccent,
                            elevation: 50.0,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => View(
                                            imageURL: imageURL,
                                            authorName: authorName,
                                            title: title,
                                            des: des,
                                          )));
                            },
                            child: Text("view"),
                            color: Colors.grey,
                            elevation: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
