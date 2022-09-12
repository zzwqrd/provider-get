import 'dart:convert';

ProductsStoreModel ProductsStoreModelFromJson(String str) => ProductsStoreModel.fromJson(json.decode(str));

class ProductsStoreModel {
  ProductsStoreModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ProductsStoreModel.fromJson(Map<String, dynamic> json) => ProductsStoreModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.name,
    required this.description,
    required this.image,
    required this.priceBeforeDiscount,
    required this.price,
    required this.id,
  });

  String name;
  String description;
  String image;
  String priceBeforeDiscount;
  String price;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        priceBeforeDiscount: json["price_before_discount"],
        price: json["price"],
        id: json["id"],
      );
}
