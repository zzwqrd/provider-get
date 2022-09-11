class ProductsModel {
  bool? status;
  List<ProductData>? data;

  ProductsModel({this.status, this.data});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  String? name;
  dynamic image;
  int? priceBeforeDiscount;
  int? price;
  String? description;

  ProductData({this.id, this.name, this.image, this.priceBeforeDiscount, this.price, this.description});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price'];
    description = json['description'];
  }
}
