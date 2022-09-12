import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mvvm_provider_practice/helper/server_gate.dart';
import 'package:mvvm_provider_practice/model/model_add.dart';

class ApiAddProducts {
  final ServerGate serverGate = ServerGate();
  ProductsStoreModel model = ProductsStoreModel();
  // [][][][][][][][][][][][][][][][][]
  Future<ProductsStoreModel> fetchData({
    ///     [][][][][][][]  هنا انا بعمل قيم مسويه للقيم الي في الموديل الي هبعته للداتا بيز سواء اسم او صوره او نص او سعر
    ///     [][][][][][][]  وبمررها مهايا للصفحه التنيه الي منها هبصي للفيو بتعاعي منها علشان تكون قيم متسويه مع الي هبعته ورجع اعرضه تاني
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required TextEditingController discountController,
    required TextEditingController priceController,
    required File image,
  }) async {
    serverGate.addInterceptors();
    CustomResponse response = await serverGate.sendToServer(
      url: 'product/store',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },

      ///     [][][][][][][] هنا بساوي كل قيمه رجعه في البوست مان بلقيمه الي بتسويها من فوق  الي محتاج امررها وكتبها من عندي
      body: {
        ///     [][][][][][][] هنا بساوي الاسم الي مبعوت ليا من الداتا بيز بلاسم الي انا نشئه جديد علشان امرره معايا كا متغير
        'name': nameController.text,

        ///     [][][][][][][] هنا بساوي الوصف الي مبعوت ليا من الداتا بيز الوصف الي انا نشئه جديد علشان امرره معايا كا متغير
        'description': descriptionController.text,

        ///     [][][][][][][] هنا بساوي التخفيض وقيمته بتكون راجعه رقم الي مبعوت ليا من الداتا بيز التخفيض الي انا نشئه جديد علشان امرره معايا كا متغير
        'price_before_discount': discountController.text,

        ///     [][][][][][][] هنا بساوي السعر وقيمته بتكون راجعه رقم الي مبعوت ليا من الداتا بيز السعر الي انا نشئه جديد علشان امرره معايا كا متغير
        'price': priceController.text,

        ///     [][][][][][][] اما هنا فا بحول الصوره معايا علشان اعرف ابعتها ودا كود التحويل بتعها وهنا مش هينفع اي تغيير خصوصا في تحويل الصوره
        if (image != null)
          "image": MultipartFile.fromFileSync(image.path, filename: image.path.split('/').last.toString(), contentType: MediaType("image", "png")),
      },
    );
    model = ProductsStoreModel.fromJson(response.response!.data);
    return model;
  }
}
