class Product {
  final String title;
  final String description;
  final String imagePath;
  final String price;
  final List<String> options;
  final double rating;
  bool isBookmarked;

  Product({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.options,
    required this.rating,
    this.isBookmarked = false,
  });
}