import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          if (cart.items.isNotEmpty)
            TextButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
              child: const Text('Clear Cart', style: TextStyle(color: Colors.white)),
            )
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: const Text('ORDER NOW'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final cartItem = cart.items.values.toList()[i];
                final bookId = cart.items.keys.toList()[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text('\$${cartItem.book.price.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(cartItem.book.title),
                      subtitle: Text('Total: \$${(cartItem.book.price * cartItem.quantity).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .updateQuantity(bookId, cartItem.quantity - 1);
                            },
                          ),
                          Text('${cartItem.quantity} x'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .updateQuantity(bookId, cartItem.quantity + 1);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .removeItem(bookId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
