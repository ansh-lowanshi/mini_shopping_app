import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_e_commerce/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mini_e_commerce/product_row.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mini_e_commerce/cart_page.dart';

final productProvider = FutureProvider<List<dynamic>>((ref) async {
  //api link
  final url = Uri.parse('https://fakestoreapi.com/products');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch products');
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        // Profil option
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              // to profil page
            },
            child: CircleAvatar(
              backgroundColor: color3,
              // we will replace the link by user's image
              backgroundImage: NetworkImage(
                  'https://stock.adobe.com/in/images/silhouette-woman-portrait/103886826'),
            ),
          ),
        ),
        // search bar
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor: color3,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
        // cart button to go to cart page
        actions: [
          IconButton(
            onPressed: () {
              // to cart page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: color3,
              size: 30,
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: color1,
      ),
      // body comes here
      body: products.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              //calling a function that will create the cards with the product details on the main page
              return ProductRow(product: products[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
