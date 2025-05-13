import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {'title': 'Apple', 'price': 1.5, 'photo': 'assets/images/apple.jpg'},
    {'title': 'Banana', 'price': 0.5, 'photo': 'assets/images/Banana2.jpg'},
    {'title': 'Orange', 'price': 1.0, 'photo': 'assets/images/orange.jpg'},
    {'title': 'Milk', 'price': 2.0, 'photo': 'assets/images/Milk.jpg'},
    {'title': 'Bread', 'price': 1.2, 'photo': 'assets/images/Bread.jpg'},
    {'title': 'Eggs', 'price': 3.0, 'photo': 'assets/images/Eggs.jpg'},
    {'title': 'Cheese', 'price': 4.5, 'photo': 'assets/images/Chees.jpg'},
    {'title': 'Tomato', 'price': 0.8, 'photo': 'assets/images/Tomato.jpg'},
  ];

  List<Map<String, dynamic>> cart = [];

  // Adding item to cart and increasing quantity if already exists
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final index = cart.indexWhere(
        (item) => item['title'] == product['title'],
      );
      if (index >= 0) {
        cart[index]['quantity'] += 1;
      } else {
        cart.add({...product, 'quantity': 1});
      }
    });
  }

  // Removing item from cart, reducing quantity or removing item if quantity is 1
  void removeFromCart(int index, Function setModalState) {
    setState(() {
      if (cart[index]['quantity'] > 1) {
        cart[index]['quantity'] -= 1; // Decrease quantity by 1
      } else {
        cart.removeAt(index); // Remove item if quantity is 1
      }
    });

    setModalState(() {}); // Update the BottomSheet
  }

  // Calculate the total price of items in the cart
  double totalCartPrice() {
    double total = cart.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    return total + 10; // Add delivery fee of 10
  }

  // Get the total number of items in the cart
  int get totalCartItems {
    return cart.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));
  }

  // Show the cart in a bottom sheet
  void showCartSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              height: 500,
              child: Column(
                children: [
                  Text(
                    'سلة المشتريات',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child:
                        cart.isEmpty
                            ? Center(
                              child: Text(
                                'السلة فارغة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cart.length,
                                    itemBuilder: (context, index) {
                                      final item = cart[index];
                                      return Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading: Image.asset(
                                            item['photo'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            '${item['title']} × ${item['quantity']}',
                                          ),
                                          subtitle: Text(
                                            'السعر: \$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              removeFromCart(
                                                index,
                                                setModalState,
                                              ); // Update BottomSheet when removing item
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'سعر التوصيل:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '\$10.00',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الإجمالي الكلي:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$${totalCartPrice().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          'Supermarket',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => showCartSheet(context),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 29,
                  color: Colors.black,
                ),
              ),
              if (totalCartItems > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      totalCartItems.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            color: Colors.white,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                product['photo'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product['title']),
              subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
              trailing: Icon(Icons.add_shopping_cart),
              onTap: () => addToCart(product), // Adding product to the cart
            ),
          );
        },
      ),
    );
  }
}
