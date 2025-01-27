import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // list to store the items details that are in the cart
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    // total amount of cart
    double totalAmount = cartNotifier.getTotalAmount();

    // cart page

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Your Cart",
          style: TextStyle(color: color6, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: color1,
      ),
      backgroundColor: color3,
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      //product image
                      leading: Image.network(
                        product.product['image'],
                        width: 50,
                        height: 50,
                      ),
                      //product title
                      title: Text(product.product['title']),
                      // price
                      subtitle: Text(
                        '\$${product.product['price']}',
                        style:
                            const TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // button to increase the item count in the cart
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              cartNotifier.decreaseQuantity(product);
                            },
                          ),
                          Text('${product.quantity}',
                              style: const TextStyle(fontSize: 18)),
                            // button to increase the item count in tht cart
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              cartNotifier.increaseQuantity(product);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // bottom bar to show total amount and checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Total price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$$totalAmount',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Checkout button
            ElevatedButton(
              onPressed: () {
                // checkout function 
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color1,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  color: color6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
