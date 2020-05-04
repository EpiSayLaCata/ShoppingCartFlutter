import 'package:flutter/material.dart';
import 'shopping_cart.dart';
import 'shopping_cart_functions.dart';
import 'package:provider/provider.dart';
import 'products.dart';

void main() => runApp(MyApp());

var productsData = ProductsData.getData;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingCartFunctions>(
      create: (context) => ShoppingCartFunctions(),
      child: MaterialApp(
        title: 'My Awesome Technical Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Products'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ShoppingCartFunctions>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCart(),
                      ),
                    );
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.red[700]),
                              new Positioned(
                                  top: 5.0,
                                  right: 6,
                                  child: new Center(
                                    child: new Text(
                                      '$totalCount',
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  ),
                )),
          )
        ],
      ),
      body: Column(
        children: List.generate(productsData.length, (index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
                    image: DecorationImage(
                      image: AssetImage(productsData[index]['Asset']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(productsData[index]['Name']),
                ),
                ButtonBar(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: '$index',
                      child: Icon(Icons.add_shopping_cart),
                      backgroundColor: Colors.blue,
                      mini: true,
                      onPressed: () {
                        bloc.addToCart(index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
