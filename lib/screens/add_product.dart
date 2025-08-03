import 'package:api/api/api_service.dart';
import 'package:api/models/product_model.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ApiService apiService = ApiService();

  final _formKey = GlobalKey<FormState>();

  String title = '';
  double price = 0.00;
  String description = '';
  String image = '';
  String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add product")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a title";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a price";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  price = double.parse(newValue!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a description";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  description = newValue!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter an image URL";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  image = newValue!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a category";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ProductModel newProduct = ProductModel(
                      title: title,
                      price: price,
                      description: description,
                      category: category,
                      image: image,
                    );
                    apiService.addProduct(newProduct).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
