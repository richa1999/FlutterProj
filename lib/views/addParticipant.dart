import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gryffindor/service/database.dart';
import 'package:gryffindor/views/conversation_screen.dart';
import 'package:gryffindor/helper/constants.dart';

class AddPeople extends StatefulWidget {
  @override
  _AddPeopleState createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController addTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;


  initiateSearch(){
    databaseMethods.getUSerByUsername(addTextEditingController.text).then((val){
                      
                      setState((){
                         searchSnapshot = val;
                      });
                      
                    });
     addTextEditingController.text = "";
  }

 Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return AddPeopleTile(
          userEmail: searchSnapshot.documents[index].data["email"],
          userName: searchSnapshot.documents[index].data["name"],);
      }): Container();
  }

   List<String> usersList = [];

  collectIDs(userName){
   
    this.usersList.add(userName);
    showAlertDialog(context);
    if(this.usersList.length >= 2){
    addParticipantsToGroup(this.usersList);
    this.usersList.length = 0;
    }
    
    
  }

  addParticipantsToGroup(usersList){
    
    
    createChatroomAndStartConversation(
      userName1: usersList[0],
      userName2: usersList[1],
    );
  }

  createChatroomAndStartConversation({String userName1,userName2}){
    
    String chatRoomID = getChatRoomId(userName1, userName2,Constants.myName);
    
    List<String> users = [userName1,userName2, Constants.myName];

    Map <String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomID": chatRoomID
    };

    DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationScreen(
         prodID: "",
        chatroomID:chatRoomID ,
       
      )));
    
  }

  Widget AddPeopleTile({String userName, String userEmail}){
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
              collectIDs(userName)(
                userName: userName
              );
            },
            child: Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical:16),
            child: Text("Add Participant", style: TextStyle(fontSize: 15,color: Colors.white),)
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
      title: const Text('Add Participants'),
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
                     controller: addTextEditingController,
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


getChatRoomId(String a,String b,String c){
  return a+b+c;

}

showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton( 
    color: Colors.pink, 
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Success!"),  
    content: Text("One Participant Added"),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}  