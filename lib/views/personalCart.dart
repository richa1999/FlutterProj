import 'package:flutter/material.dart';
import "package:gryffindor/views/cartProducts.dart";

// import 'components/body.dart';
// import 'components/check_out_card.dart';

class PersonalCart extends StatefulWidget {
  @override
  PersonalCartState createState() => PersonalCartState();
}

class PersonalCartState extends State<PersonalCart> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.pink,
          title: Text(
            'My Cart',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 24,
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
        bottomNavigationBar: new Container(
          padding: const EdgeInsets.all(6.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: new Text("Total:",
                style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
            ),
            ),
                subtitle: new Text("\u20B9 5300",
                style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 16
            ),), 
              )),
              Expanded(
                
                child: new MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Color.fromRGBO(255,20,147, 1))),
                  onPressed: () {},
                  padding: EdgeInsets.all(10.0),
                  child: new Text("Check Out",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  color: Colors.pink,
                  
                ),
              )
            ],
          ),
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
