// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gryffindor/views/chatRoom.dart';
import 'package:gryffindor/views/orderHistory.dart';
import 'package:gryffindor/views/personalCart.dart';
// import 'package:gryffindor/views/search.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:gryffindor/views/sendFile.dart';
// import 'package:gryffindor/views/shopping_cart.dart';

class Products extends StatefulWidget{
  @override
  _ProductsState createState() => _ProductsState();

}

class _ProductsState extends State<Products> {
  var productList = [
     {
      "name": "Jeans",
      "picture": "img/products/jeans.jpg",
      "price": 500,
      "id":"jeans.jpg"
    },
     {
      "name": "Jeans1",
      "picture": "img/products/jeans1.jpg",
      "price": 500,
      "id":"jeans1.jpg"
    },
    
     {
      "name": "shoe3",
      "picture": "img/products/shoe.jpg",
      "price": 500,
      "id":"shoe.jpg"
    },
     {
      "name": "shoe2",
      "picture": "img/products/shoe1.jpg",
      "price": 500,
      "id":"shoe1.jpg"
    },
     {
      "name": "dress",
      "picture": "img/products/dress.jpg",
      "price": 500,
      "id":"dress.jpg"
    },
     {
      "name": "dress2",
      "picture": "img/products/dress2.jpg",
      "price": 500,
      "id":"dress2.jpg"
    },
      {
      "name": "shoe",
      "picture": "img/products/shoe.jpg",
      "price": 500,
      "id":"shoe.jpg"
    },
     {
      "name": "shoe1",
      "picture": "img/products/shoe1.jpg",
      "price": 500,
      "id":"shoe1.jpg"
    }
    

    
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink,
        title: const Text('Gryffindor'),
        actions: <Widget>[
           Hero(tag: "btn3", 
          child:   IconButton(
          icon: const Icon(Icons.format_list_bulleted),
          tooltip: 'OrderHistor',
          onPressed: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => OrderHistory(),
                  ),
                  );
          },
        ),
          ),
          Hero(tag: "btn2", 
          child:   IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Cart',
          onPressed: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => PersonalCart(),
                  ),
                  );
          },
        ),
          ),
          Hero(tag: "btn1", 
          child:   IconButton(
          icon: const Icon(Icons.chat),
          tooltip: 'ChatRoom',
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatRoom()));
          },
        ),
          )
        ],
        ),
        body: GridView.builder(
      
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
      ), 
      itemBuilder: (BuildContext context, int index){
        return SingleProd(
          prodName: productList[index]['name'],
          prodPicture: productList[index]['picture'],
          prodPrice: productList[index]['price'],
          prodID: productList[index]['id'],
        );
      }));
  }
}


class SingleProd extends StatelessWidget {
  final prodName;
  final prodPicture;
  final prodPrice;
  final prodID;

  SingleProd({
   this.prodName,
   this.prodPicture,
   this.prodPrice,
   this.prodID
  });
  @override
  Widget build(BuildContext context) {
    return Card (
      child: Hero(
        tag: prodName, 
        child: Material(
          child: InkWell(onTap: (){},
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Text(prodName, 
                style:TextStyle(fontWeight: FontWeight.bold),
                ),
                title:Text("\$$prodPrice",
                style: TextStyle(color: Colors.pink, 
                fontWeight: FontWeight.w600),
                ),
                trailing: GestureDetector(
                  onTap: (){
                    String pID = this.prodID;
                    Navigator.push(context, MaterialPageRoute(
            builder: (context) => SendFile(prodID: pID)
            ));
                  },
                  child:Icon(Icons.send,
                color: Colors.black,
                size:20),
              )
            ),),
            child: Image.asset(prodPicture,
            fit: BoxFit.cover,) 
            ,),
            ),
          ))
    );
  
  }
}
