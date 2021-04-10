import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseMethods{
  getUSerByUsername(String username) async {
    return Firestore.instance.collection("users")
        .where("name", isEqualTo: username )
           .getDocuments();
  }

  createChatRoom(String chatRoomID, chatRoomMap){
    Firestore.instance.collection("chatRoom")
     .document(chatRoomID).setData(chatRoomMap).catchError((e){
       print(e.toString());
     });
  }

  addConversationMessages(String chatRoomID,messageMap){
    Firestore.instance.collection("chatRoom")
     .document(chatRoomID)
     .collection("chats")
     .add(messageMap).catchError((e){print(e.toString());});
  }

  getConversationMessages(String chatRoomID) async {
    return await Firestore.instance.collection("chatRoom")
     .document(chatRoomID)
     .collection("chats")
     .orderBy("time", descending: false)
     .snapshots();
  }
  
  getChatRoom(String userName) async {
    return await Firestore.instance.
    collection("chatRoom")
     .where("users", arrayContains: userName)
     .snapshots();
  }

  getProd(String prodID)async{
    final ref = FirebaseStorage.instance.ref().child(prodID);
// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    return url;
  }

}
