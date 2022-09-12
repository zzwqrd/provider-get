import 'package:flutter/material.dart';
import 'package:mvvm_provider_practice/helper/server_gate.dart';
import 'package:mvvm_provider_practice/model/model.dart';
import 'package:mvvm_provider_practice/model/model_add.dart';
import 'package:mvvm_provider_practice/services/api_service.dart';
import 'package:mvvm_provider_practice/services/base_service.dart';
import 'package:mvvm_provider_practice/utils/api_constants.dart';

class ApiProducts {
  final BaseService _apiService = ApiService();
  ProductsModel model = ProductsModel();
  Future<List<ProductData>> fetchData() async {
    dynamic response = await _apiService.getGetResponse(ApiConstants.productList);
    model = ProductsModel.fromJson(response);
    return model.data!;
  }
}

// class ApiProducts {
//   final ServerGate serverGate = ServerGate();
//   ProductsModel model = ProductsModel();
//   Future<List<ProductData>> fetchData() async {
//     serverGate.addInterceptors();
//     CustomResponse response = await serverGate.getFromServer(
//       url: 'product/index',
//     );
//     model = ProductsModel.fromJson(response.response!.data);
//     return model.data!;
//   }
// }


