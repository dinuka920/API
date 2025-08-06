import 'package:api/api/api_service.dart';
import 'package:api/models/product_model.dart';
import 'package:api/screens/edit_product.dart';
import 'package:flutter/material.dart';

class SingleProductPage extends StatelessWidget {
  final int productId;
  SingleProductPage({super.key, required this.productId});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Single Product")),
      body: SingleChildScrollView(
        child: FutureBuilder<ProductModel>(
          future: apiService.fetchSingleProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("error :${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Product Not pound"));
            } else {
              ProductModel product = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    Text(product.title, style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 8),
                    Text("\$${product.price}", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditProduct(product: product),
                              ),
                            );
                          },
                          child: Text("Update"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await apiService.deleteProduct(product.id!);
                            Navigator.pop(context);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
