import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final isInCart = cart.items.containsKey(book.id);
    final quantity = isInCart ? cart.items[book.id]!.quantity : 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${book.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (!book.isAvailable)
                    Text(
                      'Unavailable',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (isInCart)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: quantity > 1
                        ? () => cart.updateQuantity(book.id, quantity - 1)
                        : () => cart.removeItem(book.id),
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cart.addItem(book),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: book.isAvailable
                    ? () => cart.addItem(book)
                    : null,
                child: const Text('Add to Cart'),
              ),
          ],
        ),
      ),
    );
  }
}
