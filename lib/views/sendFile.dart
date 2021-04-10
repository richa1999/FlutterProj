import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gryffindor/service/database.dart';
import 'package:gryffindor/views/conversation_screen.dart';
import 'package:gryffindor/helper/constants.dart';

class SendFile extends StatefulWidget {
  final String prodID;
  SendFile({Key key, @required this.prodID}) : super(key: key);
  @override
  _SendFileState createState() => _SendFileState();
}


class _SendFileState extends State<SendFile> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;


  initiateSearch(){
    databaseMethods.getUSerByUsername(searchTextEditingController.text).then((val){
                      
                      setState((){
                         searchSnapshot = val;
                      });
                      
                    });
  }

 Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SendTile(
          userEmail: searchSnapshot.documents[index].data["email"],
          userName: searchSnapshot.documents[index].data["name"],);
      }): Container();
  }
  createChatroomAndStartConversation({String userName}){
    
    String chatRoomID = getChatRoomId(userName, Constants.myName);
    
    List<String> users = [userName, Constants.myName];

    Map <String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomID": chatRoomID
    };

    DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap); 
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationScreen(
        prodID:widget.prodID,
        chatroomID:chatRoomID,
      )));
    
  }

  Widget SendTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(fontSize: 15),),
              Text(userEmail, style: TextStyle(fontSize: 15))
            ],
          ),
          Spacer(), 
          GestureDetector(
            onTap: (){
              createChatroomAndStartConversation(
                userName: userName,
              );
            },

            child: Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical:16),
            child: Text("Send", style: TextStyle(fontSize: 15,color: Colors.white),)
          )
          )
        ],),
    );
  }
  
  
  void initState(){
    super.initState();
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
backgroundColor: Colors.pink,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical:16),
              child:  
              Row(
              children: <Widget>[
                Expanded(               
                   child: TextField(
                     controller: searchTextEditingController,
                     style: TextStyle(color: Colors.white),
                     decoration: InputDecoration(
                       hintText: "search username...",
                       hintStyle: TextStyle(
                         color: Colors.white
                       ),
                       border: InputBorder.none
                     ),

                )
                ),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
                  },
                  child: Container( 
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                  color: Colors.pink,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  padding: EdgeInsets.all(10),
                  child:Icon(Icons.search,color: Colors.white,),)
                  )
              ],
            )),
            searchList()
          ],
        ),
      ),
    );
  }
}


getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}