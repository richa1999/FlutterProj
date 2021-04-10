import 'package:flutter/material.dart';
import "package:gryffindor/views/cartProducts.dart";

// import 'components/body.dart';
// import 'components/check_out_card.dart';

class OrderHistory extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<OrderHistory> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.pink,
          title: 
               Text(
            'Order History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
         
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ],
        ),
        body: new Container(
          height: 2050,
          child: new ListView(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
              ),

              //grid View
              Container(
                height: 1500.0,
                child: CartProducts(),
              )
            ],
          ),
        ));
  }
}
