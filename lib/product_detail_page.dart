import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'package:mini_e_commerce/cart_provider.dart';
import 'package:mini_e_commerce/cart_page.dart';

class ProductDetailPage extends ConsumerWidget {
  final dynamic product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      //here the full detail of the product is shown
      appBar: AppBar(
        // app bar to add a back button
        toolbarHeight: 70,
        title: const Text(
          "Product Details",
          style: TextStyle(fontSize: 28, color: color6),
        ),
        centerTitle: true,
        backgroundColor: color1,
        actions: [
          IconButton(
            onPressed: () {
              // to go to cart page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: Icon(
              // cart logo
              Icons.shopping_cart_outlined,
              color: color3,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.network(
                  product['image'],
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 15),
              // Product Name
              Text(
                product['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Price and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '\$${product['price']}',
                      style: const TextStyle(fontSize: 30, color: Colors.green),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        product['rating']['rate'].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        ' (${product['rating']['count']})',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                product['description'],
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      // button to add item to cart and display the message
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
            onPressed: () {
              final cartNotifier = ref.read(cartProvider.notifier);
              cartNotifier.addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item added to cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color1,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text("Add to Cart", style: TextStyle(
              color: color6,
            ),)
            ),
      ),
    );
  }
}
