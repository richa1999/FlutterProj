import 'package:flutter/material.dart';
import 'package:gryffindor/service/database.dart';
import 'package:gryffindor/helper/constants.dart';
import 'package:gryffindor/views/conversation_screen.dart';
import 'dart:async';
import './call.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:gryffindor/views/orderHistory.dart';
import 'package:gryffindor/views/shopping_cart.dart';


class ProductSharing extends StatefulWidget {
  final String prodID;
  final String chatroomID;
  
  ProductSharing({Key key, @required this.prodID, this.chatroomID}) : super(key: key);
  // ConversationScreen({Key key, @required this.chatRoomID}) : super(key: key);
  

  @override 
  _ProductSharingScreen createState() => _ProductSharingScreen();
}

class _ProductSharingScreen extends State<ProductSharing> {
  
  final _channelController = TextEditingController();

  

  // ClientRole _role = ClientRole.Broadcaster;

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

 
 
   @override 
   void initState(){
     databaseMethods.getConversationMessages(widget.chatroomID).then((value){
       setState(() {
         if(widget.prodID.isNotEmpty){
           databaseMethods.getProd(widget.prodID).then((valueurl){
        
                    this.imageurl= valueurl ;
      
                    });
         }
        //  chatMessageStream = value;
       });
     });
     
     super.initState();
   }


  @override 
  Widget build(BuildContext context) {
    return 
        ImageTile(this.imageurl);
    
  }
}



// class MessageTile extends StatelessWidget{
//   final String imageurl;
//   final String message;
//   final String sendBy;
//   final bool isSendByMe;
//   final bool imgurl;
//   MessageTile(this.imageurl,this.message, this.sendBy,this.isSendByMe,this.imgurl);

//   @override 
//   Widget build(BuildContext context){
//     return  Container(
//       padding: EdgeInsets.only(left: isSendByMe ? 0:24, right: isSendByMe ? 24:0),
//       margin: EdgeInsets.symmetric(vertical: 8),
//       width: MediaQuery.of(context).size.width,
//       alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
//       child:Column( 
//         children:<Widget>[
//       Container(
//         padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isSendByMe ? [
//               const Color(0xff007EF4),
//               const Color(0xff2A75BC)
//             ]
//               : [
//                 const Color(0x3AFFFFFF),
//                 const Color(0x3AFFFFFF)
                
//               ],
//             ),
//             borderRadius: isSendByMe ? BorderRadius.only(
//               topLeft: Radius.circular(23),
//               topRight: Radius.circular(23),
//               bottomLeft: Radius.circular(23)
//             ) :
//             BorderRadius.only(
//               topLeft: Radius.circular(23),
//               topRight: Radius.circular(23),
//               bottomRight: Radius.circular(23)
//               )
//         ),
//       child:
//       Column(
//         children: <Widget>[
//         Text(
//         message,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 17),
//       ),
//       Text(
//         "-"+sendBy,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 12),
//       ),
      
  
//         ],
//         ),
           
//       ),
      
//        imgurl ? Container():ImageTile(this.isSendByMe,this.imageurl)
//           ]));
//   }
// }

class ImageTile extends StatelessWidget{
  // final bool isSendByMe;
  final String imageUrl;
  ImageTile(this.imageUrl);

   Widget build(BuildContext context){
    return  Container(
        alignment:  Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        child:Column(
          children:<Widget>[
            ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage(placeholder: AssetImage("img/products/dress2.jpg"), image: NetworkImage(imageUrl)))
          ])
    );}
}