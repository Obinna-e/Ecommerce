import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action));
}

//create global reducer which handles all of app state and then return individual reducers

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    //return user from given action
    return action.user;
  }
  //check if given action is an instance of a class{}
  return user;
}

//reponsible for updating userstate

productsReducer(products, action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}
