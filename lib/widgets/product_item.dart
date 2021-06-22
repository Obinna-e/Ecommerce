import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/pages/product_detail_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductItem extends StatelessWidget {
  final Product item;

  ProductItem({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://localhost:1337${item.picture[0].url}';
    return InkWell(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ProductDetailPage(item: item); //page created on the fly
      })),
      child: GridTile(
        footer: GridTileBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              item.name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          subtitle: Text(
            '\$${item.price}',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Color(0xBB000000),
          trailing: StoreConnector<AppState, AppState>(
              builder: (_, state) {
                return state.user != null
                    ? IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () => print('Pressed'),
                      )
                    : Text('');
              },
              converter: (store) => store.state),
        ),
        child: Image.network(
          pictureUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//Grid Tiles are standard childs of grid view
