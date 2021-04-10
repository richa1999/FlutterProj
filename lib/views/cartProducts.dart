import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  CartProductsState createState() => CartProductsState();
}

class CartProductsState extends State<CartProducts> {
  var productsonthecart = [
    {
      "name": "Calvin Klein Jeans",
      "subname": "Women Blue Skinny Fit Mid-Rise Clean Look Stretchable Jeans",
      "picture": "img/products/jeans.jpg",
      "price": 850,
      "size": "M",
      "quantity": 1,
    },
    {
      "name": "Roadster",
      "subname": "Women Blue Skinny Fit Mid-Rise Clean Look Stretchable Jeans",
      "picture": "img/products/jeans1.jpg",
      "price": 500,
      "size": "M",
      "quantity": 1,
    },
    {
      "name": "Nike",
      "subname": "Women Blue Skinny Fit Mid-Rise Clean Look Stretchable Jeans",
      "picture": "img/products/shoe.jpg",
      "price": 1800,
      "size": "M",
      "quantity": 1,
    },
    {
      "name": "Nike",
      "subname": "Women Blue Skinny Fit Mid-Rise Clean Look Stretchable Jeans",
      "picture": "img/products/shoe.jpg",
      "price": 1850,
      "size": "M",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: productsonthecart.length,
        itemBuilder: (context, index) {
          return Singlecartproduct(
            cartprodname: productsonthecart[index]["name"],
            cartprodsubname: productsonthecart[index]["subname"],
            cartprodprice: productsonthecart[index]["price"],
            cartprodqty: productsonthecart[index]["qauntity"],
            cartprodsize: productsonthecart[index]["size"],
            cartprodpicture: productsonthecart[index]["picture"],
          );
        });
  }
}

class Singlecartproduct extends StatelessWidget {
  final cartprodname;
  final cartprodsubname;
  final cartprodpicture;
  final cartprodprice;
  final cartprodsize;
  final cartprodqty;

  Singlecartproduct({
    this.cartprodname,
    this.cartprodsubname,
    this.cartprodpicture,
    this.cartprodprice,
    this.cartprodsize,
    this.cartprodqty,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: new Image.asset(
          cartprodpicture,
          width: 90.0,
          height: 80.0,
          fit: BoxFit.fitWidth,
        ),
        title: new Text(
          cartprodname,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cartprodsize,
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Qty:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(.0),
                  child: new Text(
                    "1",
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ],
            ),
            new Container(
              alignment: Alignment.topRight,
              child: new Text(
                "\u20B9 $cartprodprice",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            )
          ],
        ),
        // trailing: new Column(
        //   children: <Widget>[
        //     const IconData arrow_drop_up_sharp = IconData(0xeb53, fontFamily: 'MaterialIcons');
        //     new Text(cartprodqty),
        //     new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: () {})
        //   ],
        // ),
        // trailing: Wrap(
        //   children: <Widget>[Icon(Icons.add), Text("1"), Icon(Icons.remove)],
        // ),
      ),
    );
  }
}
