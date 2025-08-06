import 'package:api/api/api_service.dart';
import 'package:api/models/product_model.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final ProductModel product;
  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late String title;
  late double price;
  late String description;
  late String imageUrl;
  late String category;

  @override
  void initState() {
    super.initState();
    title = widget.product.title;
    price = widget.product.price;
    description = widget.product.description;
    imageUrl = widget.product.image;
    category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  price = double.parse(newValue!);
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  description = newValue!;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: imageUrl,
                decoration: InputDecoration(labelText: "Image Url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an Image Url";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  imageUrl = newValue!;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: category,
                decoration: InputDecoration(labelText: "Category"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a category";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ProductModel updatedProduct = ProductModel(
                      title: title,
                      price: price,
                      description: description,
                      category: category,
                      image: imageUrl,
                    );

                    try {
                      await apiService.updateProduct(
                        widget.product.id!,
                        updatedProduct,
                      );
                      Navigator.pop(context);
                    } catch (error) {
                      print("Error: $error");
                    }
                  }
                },
                child: const Text("Update Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
