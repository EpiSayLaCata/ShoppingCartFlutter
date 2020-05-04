import 'package:flutter/material.dart';
import 'shopping_cart_functions.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ShoppingCartFunctions>(context);
    var cart = bloc.cart;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          int giftIndex = cart.keys.toList()[index];
          int count = cart[giftIndex];
          return ListTile(
            leading: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/pic${giftIndex + 1}.jpg"),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            title: Text('Quantity: $count'),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.remove,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    bloc.subQuantity(giftIndex, context);
                  },
                ),
                IconButton(
                  icon: new Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    bloc.addQuantity(giftIndex);
                  },
                ),
                IconButton(
                  icon: new Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    bloc.clear(giftIndex);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          bloc.displaySum(context);
        },
        label: Text('Buy'),
        icon: Icon(Icons.shopping_basket),
        backgroundColor: Colors.pink,
      ),
    );
  }
}