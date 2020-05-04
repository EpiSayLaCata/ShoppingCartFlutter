import 'package:flutter/material.dart';

class ShoppingCartFunctions with ChangeNotifier {
  Map<int, int> _cart = {};
  Map<int, int> get cart => _cart;

  int potatoes = 5;
  int carrots = 4;
  int onions = 2;

  var totalPotatoes = 0;
  var totalCarrots = 0;
  var totalOnions = 0;
  var totalAll = 0;

  void addToCart(index) {
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
    } else {
      _cart[index] = 1;
    }
    notifyListeners();
  }

  void addQuantity(index) {
    if (cart.containsKey(index)) {
      _cart[index] += 1;
    }
    notifyListeners();
  }

  void subQuantity(index, context) {
    if (_cart[index] <= 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Warning !"),
            content: Text("Do you really want to remove this item from your basket ?"),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  addQuantity(index);
                  notifyListeners();
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _cart.remove(index);
                  notifyListeners();
                },
              ),
            ],
          )
      );
    }

    if (cart.containsKey(index)) {
      _cart[index] -= 1;
    }
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }

  void displaySum(context) {
    notifyListeners();
    if (_cart[0] != null) {
      totalPotatoes = _cart[0] * potatoes;
    } else {
      totalPotatoes = 0;
    }
    if (_cart[1] != null) {
      totalCarrots = _cart[1] * carrots;
    } else {
      totalCarrots = 0;
    }
    if (_cart[2] != null) {
      totalOnions = _cart[2] * onions;
    } else {
      totalOnions = 0;
    }
    if (_cart[0] == null && _cart[1] == null && _cart[2] == null) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Your basket is empty !'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Oops'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      totalAll = totalPotatoes + totalCarrots + totalOnions;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text("My Awesome Basket !"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Potatoes : $totalPotatoes AED'),
                  Text('Carrots : $totalCarrots AED'),
                  Text('Onions : $totalOnions AED'),
                  Text('Your total basket is : $totalAll AED'),
                ],
              ),
            ),
            actions: <Widget>[
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text('Cool'),
                icon: Icon(Icons.thumb_up),
                backgroundColor: Colors.pink,
              ),
            ],
          )
      );
    }
    notifyListeners();
  }
}