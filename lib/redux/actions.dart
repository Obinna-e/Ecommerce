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
  /*Above done first to collect instance and process logged in save on local 
  phone */
  final String storedUser = prefs.getString('user');
  // final user = storedUser != null ? json.decode(storedUser) : null; old way
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  store.dispatch(GetUserAction(user));
};
ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class LogoutUserAction {
  final User _user;
  User get user => this._user;

  LogoutUserAction(this._user);
}

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

/*Cart Product Actions */

ThunkAction<AppState> toggleCartProductAction(Product cartProduct) {
  return (Store<AppState> store) {
    final List<Product> cartProducts = store.state.cartProducts;
    //get assess to current state of cart products
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    //check the current list of products and see if an instance of cart products exists
    bool isInCart = index > -1 == true;
    List<Product> updatedCartProducts = List.from(cartProducts);
    if (isInCart) {
      updatedCartProducts.removeAt(index);
      /*could have removed directly with cartProducts.removeAt()
      but we don't want to mutate with actions, so make copy and update to copy 
      instead. List cartProducts is final*/
    } else {
      updatedCartProducts.add(cartProduct);
    }
    store.dispatch(
      ToggleCartProductAction(updatedCartProducts),
    );
  };
}

class ToggleCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ToggleCartProductAction(this._cartProducts);
}
