import 'package:flutter/material.dart';
import 'package:gryffindor/service/database.dart';
import 'package:gryffindor/helper/constants.dart';
import 'package:gryffindor/views/ProductSharing.dart';
import 'package:gryffindor/views/productsDetail.dart';
import 'dart:async';
import './call.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:gryffindor/views/orderHistory.dart';
import 'package:gryffindor/views/shopping_cart.dart';



class ConversationScreen extends StatefulWidget {
  final String prodID;
  final String chatroomID;
  
  ConversationScreen({Key key, @required this.prodID, this.chatroomID}) : super(key: key);
  // ConversationScreen({Key key, @required this.chatRoomID}) : super(key: key);
  

  @override 
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  
  final _channelController = TextEditingController();

  

  /// if channel textField is validated to have error
  

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }


  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessageStream;
  String imageurl;

  Widget ChatMessageList(){
     return StreamBuilder(
       stream: chatMessageStream,
       builder: (context, snapshot){
         return snapshot.hasData ? ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (context, index){
             return MessageTile(imageurl,snapshot.data.documents[index].data["message"],
              snapshot.data.documents[index].data["sendBy"],
             snapshot.data.documents[index].data["sendBy"] == Constants.myName,
             imageurl != Constants.iurl
             
             );
           }) : Container();
       });
  }

  sendMessage(){

    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
      "message" : messageController.text,
      "sendBy": Constants.myName,
      "time" : DateTime.now().millisecondsSinceEpoch
       
    };
    databaseMethods.addConversationMessages(widget.chatroomID, messageMap);
    messageController.text = "";
    }
    
  }

   @override 
   void initState(){
     databaseMethods.getConversationMessages(widget.chatroomID).then((value){
       setState(() {
         if(widget.prodID.isNotEmpty){
           databaseMethods.getProd(widget.prodID).then((valueurl){
        
                    this.imageurl= valueurl ;
      
                    }         );
         }
         chatMessageStream = value;
       });
     });
     
     super.initState();
   }


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
          title: Text(
               widget.chatroomID
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myName, "")),
         actions: <Widget>[
         Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:Row(
              children: <Widget>[
                  GestureDetector(
                  onTap: (){
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ShoppingCart(),
                  ),
                  );
                    
                  },
                  child:Icon(Icons.shopping_cart),
                  ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Icon(Icons.phone),
            Padding(padding: EdgeInsets.only(right: 10)),
            GestureDetector(
                  onTap: (){
                    _channelController.text = "VideoCall";
                    
                     onJoin();
                  },
                  child:Icon(Icons.video_call),
              ),
            Padding(padding: EdgeInsets.only(right: 10)),
            GestureDetector(
                  onTap: (){
                   Navigator.push(
                    context,
                 MaterialPageRoute(
                builder: (context) => OrderHistory(),
                 ),
                );
                    
                  },
                  child:Icon(Icons.format_list_bulleted)),
             
            
            ],)
          ),
           
        ],
      ),
      body: Container(
        child: Stack(
          children:<Widget>[
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
            child:
            Container( 
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical:16),
              child:  
              Row(
              children: <Widget>[
                Expanded(               
                   child: TextField(
                    controller: messageController,
                     style: TextStyle(color: Colors.white),
                     decoration: InputDecoration(
                       hintText: "Message...",
                       hintStyle: TextStyle(
                         color: Colors.white
                       ),
                       border: InputBorder.none
                     ),

                )
                ),
                GestureDetector(
                  onTap: (){
                    sendMessage();
                  },
                  child: Container( 
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  padding: EdgeInsets.all(10),
                  child:Icon(Icons.send,color: Colors.white,),)
                  )
              ],
            ))),
          ] ,
          ) ,
          ),
          );
  }

   Future<void> onJoin() async {
    // update input validation
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}



class MessageTile extends StatelessWidget{
  final String imageurl;
  final String message;
  final String sendBy;
  final bool isSendByMe;
  final bool imgurl;
  MessageTile(this.imageurl,this.message, this.sendBy,this.isSendByMe,this.imgurl);

  @override 
  Widget build(BuildContext context){
    return imgurl ? Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0:24, right: isSendByMe ? 24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child:Column( 
        children:<Widget>[
          Container(
        // alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        // padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        child:Column(
          children:<Widget>[
           GestureDetector(
             onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProductDetails(imgUrl: imageurl,),
                  ),
                  );
             },
             child:ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage(width:150,placeholder: AssetImage("img/products/placeholder.png"), image: NetworkImage(imageurl)))
           ) 
          
          ])),
      Container(
        padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
            Colors.pink[300],
                Colors.pink[300],
            ]
              : [
              
               Colors.pink[300],
                Colors.pink[300],
                
              ],
            ),
            borderRadius: isSendByMe ? BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
              )
        ),
      child:
      Column(
        children: <Widget>[
        Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17),
      ),
      Text(
        "-"+sendBy,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12),
      ),
      
  
        ],
        ),
           
      ),
      
      
          ]))
          :
          Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0:24, right: isSendByMe ? 24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child:Column( 
        children:<Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              
          Colors.pink[300],
                Colors.pink[300],
            ]
              : [
                
               
               Colors.pink[300],
                Colors.pink[300],
              ],
            ),
            borderRadius: isSendByMe ? BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
              )
        ),
      child:
      Column(
        children: <Widget>[
        Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17),
      ),
      Text(
        "-"+sendBy,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12),
      ),
      
  
        ],
        ),
           
           )]));
  }
}