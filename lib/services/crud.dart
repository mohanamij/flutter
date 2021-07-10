import "package:cloud_firestore/cloud_firestore.dart";

class CrudMethods {
  Future<void> addData(blogdata) async {
    String id = FirebaseFirestore.instance.collection("blogs").doc().id;
    blogdata['id'] = id;
    blogdata['createdAt'] = DateTime.now().toString();
    FirebaseFirestore.instance
        .collection("blogs")
        .doc(id)
        .set(blogdata)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance
        .collection("blogs")
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  deleteUser(id) {
    return FirebaseFirestore.instance
        .collection("blogs")
        .doc(id)
        .delete()
        .then((value) => print("Deleted user"))
        .catchError((error) => print(error));
  }

  Future<QuerySnapshot> getAllDocumentsOfBlogs() async {
    return await FirebaseFirestore.instance.collection("blogs").get();
  }
}
