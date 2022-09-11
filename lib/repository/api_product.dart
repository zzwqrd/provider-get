import 'package:mvvm_provider_practice/model/model.dart';
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
