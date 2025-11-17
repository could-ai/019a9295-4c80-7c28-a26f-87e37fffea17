import 'package:flutter/foundation.dart';
import 'book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  double get totalPrice => book.price * quantity;
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalQuantity => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(Book book, {int quantity = 1}) {
    if (!book.isAvailable || quantity <= 0) {
      // Prevent adding unavailable or invalid books
      return;
    }

    if (_items.containsKey(book.id)) {
      _items[book.id]!.quantity += quantity;
    } else {
      _items[book.id] = CartItem(book: book, quantity: quantity);
    }
    notifyListeners();
  }

  void updateQuantity(String bookId, int newQuantity) {
    if (newQuantity <= 0 || !_items.containsKey(bookId)) {
      return;
    }
    _items[bookId]!.quantity = newQuantity;
    notifyListeners();
  }

  void removeItem(String bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String bookId) {
    return _items.containsKey(bookId);
  }

  int getQuantity(String bookId) {
    return _items[bookId]?.quantity ?? 0;
  }
}