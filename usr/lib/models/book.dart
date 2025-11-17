class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.isAvailable = true,
  });
}
