import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_provider_practice/model/model.dart';
import 'package:mvvm_provider_practice/repository/api_product.dart';

class ProductListViewModel with ChangeNotifier {
  List<ProductData> list = [];
  // ProductsModel model = ProductsModel();
  Future<void> getData() async {
    try {
      list = await ApiProducts().fetchData();
      notifyListeners();
    } catch (e) {
      print('--*-*-*-*-*-*-*-*-*-*-*-*--$e--*-*-*-*-*-*-*-*-*-*-*-*--');
      log(e.toString());
    }

    notifyListeners();
  }
}
