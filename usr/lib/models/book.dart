class Book {
  final String id;
  final String title;
  final double price;
  final bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.price,
    required this.isAvailable,
  });

  // Mock data for demonstration
  static List<Book> mockBooks = [
    Book(id: '1', title: 'Flutter Development Guide', price: 29.99, isAvailable: true),
    Book(id: '2', title: 'Dart Programming', price: 24.99, isAvailable: true),
    Book(id: '3', title: 'Mobile App Design', price: 34.99, isAvailable: false),
    Book(id: '4', title: 'UI/UX Best Practices', price: 19.99, isAvailable: true),
    Book(id: '5', title: 'State Management in Flutter', price: 27.99, isAvailable: true),
  ];
}