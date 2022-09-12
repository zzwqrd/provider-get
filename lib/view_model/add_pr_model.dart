import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm_provider_practice/model/model_add.dart';
import 'package:mvvm_provider_practice/repository/add_prodact_controler.dart';

///     [][][][][][][][][][][][][][][][][][][][][]
///  الكود طويل سيكه بس لازم في  البوست لما نضيف للداتا بيز اي عنصر لازم نباصيه معنا ونساوي قيمته في الي بعتنها بلقيمه الي في الفيو
///     [][][][][][][][][][][][][][][][][][][][][]
class AddProductListViewModel with ChangeNotifier {
  ProductsStoreModel model = ProductsStoreModel();
  Future<void> getData({
    ///     [][][][][][][] هنا بمرر الاسم الي هضيفه
    required TextEditingController nameController,

    ///     [][][][][][][] هنا بمرر الوصف الي هضيفه
    required TextEditingController descriptionController,

    ///     [][][][][][][] هنا بمرر التخفيض الي هضيفه
    required TextEditingController discountController,

    ///     [][][][][][][] هنا بمرر السعر الي هضيفه
    required TextEditingController priceController,

    ///     [][][][][][][] هنا بمرر الصوره  الي هضيفه
    required File image,
  }) async {
    try {
      ///     [][][][][][][]  بمررها هنا وبسويها بلقيم الي  في الصفحه التنيه
      model = await ApiAddProducts().fetchData(
        nameController: nameController,
        descriptionController: descriptionController,
        discountController: discountController,
        priceController: priceController,
        image: image,
      );
      notifyListeners();
    } catch (e) {
      print('--*-*-*-*-*-*-*-*-*-*-*-*--$e--*-*-*-*-*-*-*-*-*-*-*-*--');
      log(e.toString());
    }

    notifyListeners();
  }
}
