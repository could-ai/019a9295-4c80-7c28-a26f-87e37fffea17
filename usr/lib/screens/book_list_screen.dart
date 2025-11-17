import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/models/book.dart';
import 'package:couldai_user_app/providers/cart_provider.dart';
import 'package:couldai_user_app/screens/cart_screen.dart';

class BookListScreen extends StatelessWidget {
  final List<Book> _books = [
    Book(id: 'b1', title: 'The Lord of the Rings', author: 'J.R.R. Tolkien', price: 25.99),
    Book(id: 'b2', title: 'The Hobbit', author: 'J.R.R. Tolkien', price: 15.99),
    Book(id: 'b3', title: 'Pride and Prejudice', author: 'Jane Austen', price: 12.99, isAvailable: false),
    Book(id: 'b4', title: 'To Kill a Mockingbird', author: 'Harper Lee', price: 14.99),
  ];

  BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookstore'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CartScreen()));
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(_books[i].title),
          subtitle: Text('${_books[i].author} - \$${_books[i].price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: _books[i].isAvailable ? () {
              Provider.of<CartProvider>(context, listen: false).addItem(_books[i]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added item to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).updateQuantity(_books[i].id, Provider.of<CartProvider>(context, listen: false).items[_books[i].id]!.quantity-1);
                    },
                  ),
                ),
              );
            } : null,
          ),
        ),
      ),
    );
  }
}
