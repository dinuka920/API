class ProductModel {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromjson(Map<String, dynamic> json) {
    return ProductModel(
      title: json["title"],
      price: json["price"].toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
    };
  }
}
