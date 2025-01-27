import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_e_commerce/colors.dart';
import 'package:mini_e_commerce/product_detail_page.dart';
import 'package:mini_e_commerce/cart_provider.dart';
// import 'package:mini_e_commerce/cart_page.dart';

class ProductRow extends ConsumerWidget {
  final dynamic product;
  const ProductRow({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // gesture detector to to open the full detail page of the product
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                // calling product detail page function
                builder: (context) => ProductDetailPage(product: product)));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        // card starts here
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // in a row first image then detail column
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 130,
                height: 150,
                padding: EdgeInsets.all(8),
                child: Image.network(
                  product['image'],
                  fit: BoxFit.contain,
                ),
              ),
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //column to display differet details 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      // Product Rating
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            product['rating']['rate'].toString(),
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            ' (${product['rating']['count']})',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Product Price
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      SizedBox(height: 8),
                      // Add to Cart Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // adding item to cart and displaying a message
                            final cartNotifier =
                                ref.read(cartProvider.notifier);
                            cartNotifier.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Item added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: color6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
