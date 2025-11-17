import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final String cartItemId;
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItemId, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

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
                    cartItem.book.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${cartItem.book.price.toStringAsFixed(2)} each',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Total: \$${cartItem.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: cartItem.quantity > 1
                      ? () => cart.updateQuantity(cartItemId, cartItem.quantity - 1)
                      : () => cart.removeItem(cartItemId),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    initialValue: cartItem.quantity.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onFieldSubmitted: (value) {
                      final newQuantity = int.tryParse(value);
                      if (newQuantity != null && newQuantity > 0) {
                        cart.updateQuantity(cartItemId, newQuantity);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cart.addItem(cartItem.book),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cart.removeItem(cartItemId),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
