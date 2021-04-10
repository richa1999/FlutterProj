import 'package:flutter/material.dart';
import 'package:gryffindor/service/database.dart';
import 'package:gryffindor/views/conversation_screen.dart';
import 'package:gryffindor/views/search.dart';
import 'package:gryffindor/helper/constants.dart';
import 'package:gryffindor/views/addParticipant.dart';

class ChatRoom extends StatefulWidget{
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom>{

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
             return ChatRoomTile(
               snapshot.data.documents[index].data["chatroomID"]
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myName, ""),
                snapshot.data.documents[index].data["chatroomID"]
             );

          }): Container();
      },);
  }

  void initState(){
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
       databaseMethods.getChatRoom(Constants.myName).then((value){
         setState(() {
           chatRoomStream = value;
         });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink,
        title: const Text('ChatRoom'),
      
        ),
        body: chatRoomList(),
        floatingActionButton: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchScreen()
            ));
        },
        heroTag: null,
        backgroundColor: Colors.pink),
        
      SizedBox(
        height: 10,
      ),
      FloatingActionButton(           
        child: Icon(
          Icons.add
        ),
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddPeople()
            ));
        },
      heroTag: null,
      backgroundColor: Colors.pink
      )
    ]
  ));
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomID;
  ChatRoomTile(this.userName,this.chatRoomID);

  @override 
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(prodID:"",chatroomID:chatRoomID)));
      },
      child: Container(
        color: Colors.white70,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: <Widget>[
          Container(
            height: 42,
            width: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:Colors.pink,
              borderRadius: BorderRadius.circular(60)
            ),
            child: Text("${userName.substring(0,1).toUpperCase()}",
            style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Text(userName, style: TextStyle(fontSize: 18),)
        ],)
    ));
  }
}