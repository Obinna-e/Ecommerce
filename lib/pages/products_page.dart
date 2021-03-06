import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';
import 'package:flutter_ecommerce/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/actions.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700],
    ],
  ),
);

class ProductsPage extends StatefulWidget {
  final void Function() onInit;

  ProductsPage({this.onInit});

  //() added so it's executed immediately after app load

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          leading: state.user != null
              ? IconButton(
                  icon: Icon(Icons.store),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                )
              : Text(''),
          title: SizedBox(
            child: state.user != null
                ? Text(state.user.username)
                : FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'Register Here',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(
                  right: 12.0,
                ),
                child: StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(logoutUserAction);
                  },
                  builder: (_, callback) {
                    return state.user != null
                        ? IconButton(
                            icon: Icon(Icons.exit_to_app),
                            onPressed: callback,
                          )
                        : Text('');
                  },
                )),
          ],
        );
      },
    ),
    preferredSize: Size.fromHeight(60.0),
  );

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: gradientBackground,
        child: StoreConnector<AppState, AppState>(
            builder: (_, state) {
              return Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 3,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1.0 : 1.3,
                        ), //Grid with fixed no of columns
                        itemCount: state.products.length,
                        itemBuilder: (context, i) => ProductItem(
                          item: state.products[i],
                        ),
                      ),
                      top: false,
                      bottom: false,
                    ),
                  ),
                ],
              );
            } //Most times context not needed so '_' can replace it
            ,
            converter: (store) => store.state),
      ),
    );
  }
  //   return StoreConnector<AppState, AppState>(
  //       builder: (context, state) {
  //         return state.user != null ? Text(state.user.username) : Text('');
  //       },
  //       converter: (store) => store.state);
  // }
  //converter gets access from store

  //thunkAction that gives state.user is asynchronous so check if data exists
}
