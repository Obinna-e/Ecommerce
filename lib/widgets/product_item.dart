import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final dynamic item;

  ProductItem({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://localhost:1337${item['picture']['url']}';
    return GridTile(
        footer: GridTileBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              item.name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        child: Image.network(
          pictureUrl,
          fit: BoxFit.cover,
        ));
  }
}
