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

  // fetch a single product from the API
  Future<ProductModel> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        ProductModel product = ProductModel.fromjson(
          json.decode(responce.body),
        );
        return product;
      } else {
        print("Faild to fetch product status code :${responce.statusCode}");
        throw Exception("Faild to fetch product");
      }
    } catch (error) {
      print("error :$error");
      throw Exception("Feild to fatch product");
    }
  }
}
