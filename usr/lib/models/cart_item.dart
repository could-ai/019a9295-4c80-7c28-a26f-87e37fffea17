import 'package:couldai_user_app/models/book.dart';

class CartItem {
  final String id;
  final Book book;
  int quantity;

  CartItem({
    required this.id,
    required this.book,
    this.quantity = 1,
  });
}
