import 'dart:convert';

import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/app_state.dart';

/*User Actions */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  // final user = storedUser != null ? json.decode(storedUser) : null; old way
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final User _user;
  //type updated from type dynamic because this was logged in user.dart

  User get user => this._user;

  //create getter so can do action.user in reducer to update state

  GetUserAction(this._user);
}

//this just accepts the user data

/* products actions */

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http.get('http://localhost:1337/products');
  final List<dynamic> responseData = json.decode(response.body);
  print(responseData);
  List<Product> products = [];
  // store.dispatch(GetProductsAction(responseData)); old method

  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<Product> _products;
  List<Product> get products => this._products;

  GetProductsAction(this._products);
}
