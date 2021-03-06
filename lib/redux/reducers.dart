import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action),
    cartProducts: cartProducts(state.cartProducts, action),
  );
}

//create global reducer which handles all of app state and then return individual reducers

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    //return user from given action
    return action.user;
  }
  //check if given action is an instance of a class{}
  else if (action is LogoutUserAction) {
    return action.user;
    /*same as with GetUserAction, but user value is different, 
        because user retreived from actions and passed here is different */
  }
  return user;
}

//reponsible for updating userstate

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is ToggleCartProductAction) {
    return action.cartProducts; //return updated list from actions.dart
  }
  return cartProducts;
}
