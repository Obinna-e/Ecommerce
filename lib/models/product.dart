import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Product {
  String id;
  String name;
  String description;
  num price;
  List<Picture> picture;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.picture,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['picture'] as List;
    List pictureList = list.map((i) => Picture.fromJson(i)).toList();
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      picture: pictureList,
    );
  }
}

class Picture {
  String url;

  Picture({this.url});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      url: json['url'],
    );
  }
}
