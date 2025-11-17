import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/book.dart';
import 'package:couldai_user_app/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.book.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Book book, {int quantity = 1}) {
    if (!book.isAvailable || quantity <= 0) {
      return; // Prevent adding unavailable or invalid books
    }
    if (_items.containsKey(book.id)) {
      _items.update(
        book.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          book: existingCartItem.book,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        book.id,
        () => CartItem(
          id: DateTime.now().toString(),
          book: book,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(String bookId, int quantity) {
    if (quantity <= 0 || !_items.containsKey(bookId)) {
      if (_items.containsKey(bookId) && quantity <= 0) {
        _items.remove(bookId);
      }
      notifyListeners();
      return;
    }
    _items.update(
      bookId,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        book: existingCartItem.book,
        quantity: quantity,
      ),
    );
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
}
