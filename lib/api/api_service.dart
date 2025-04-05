import 'dart:convert';

import 'package:api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // fetch all products from API
  Future<List<ProductModel>> fetchAllProducts() async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        List<dynamic> responceData = json.decode(responce.body);
        List<ProductModel> products =
            responceData.map((json) {
              return ProductModel.fromjson(json);
            }).toList();
        return products;
      } else {
        print(
          "faild to fetch the products states code: ${responce.statusCode}",
        );
        throw Exception("Faild to fetch products");
      }
    } catch (error) {
      print("Error : $error");
      throw Exception("Faild to fetch products");
    }
  }
}
