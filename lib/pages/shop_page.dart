// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShopPage(),
    );
  }
  
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser; // You need to sign in the user before accessing this.
  final _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> cartItems = [];
List<Map<String, dynamic>> products1 = [];
  List<Map<String, dynamic>> cartItems1 = [];

  // Reference to the Firestore database
 
  // Reference to the Firebase auth instance
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    products = [
      {'name': 'Motard Front Axle sliders', 'price': 'R400', 'image': Image.asset('images/AMC FRONT axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Front Axle sliders bobbin replacement', 'price': 'R250', 'image': Image.asset('images/Front Bobbin Replacement.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders', 'price': 'R450', 'image': Image.asset('images/AMC rear axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders bobbin replacement', 'price': 'R300', 'image': Image.asset('images/AMC rear bobbin axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders', 'price': 'R400', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders puk replacement', 'price': 'R200', 'image': Image.asset('images/Footpeg puks.png'), 'color': '', 'isSelected': false,},
      {'name': 'Overflow bottle ', 'price': 'R250', 'image': Image.asset('images/Overflow Bottle Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Laptimer bracket', 'price': 'R250', 'image': Image.asset('images/Laptimer Bracket Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Velocity Gear Rack', 'price': 'R700', 'image': Image.asset('images/Gear Rack AMC (2).jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Apex Axle sliders', 'price': 'R950', 'image': Image.asset('images/Apex Axle Sliders Final.png'), 'color': '', 'isSelected': false,}
    ];

      products1 = [
      {'name': 'Motard Front Axle sliders', 'price': 'R400', 'image': Image.asset('images/AMC FRONT axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Front Axle sliders bobbin replacement', 'price': 'R250', 'image': Image.asset('images/Front Bobbin Replacement.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders', 'price': 'R450', 'image': Image.asset('images/AMC rear axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders bobbin replacement', 'price': 'R300', 'image': Image.asset('images/AMC rear bobbin axle sliders.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders', 'price': 'R400', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders puk replacement', 'price': 'R200', 'image': Image.asset('images/Footpeg puks.png'), 'color': '', 'isSelected': false,},
      {'name': 'Overflow bottle ', 'price': 'R250', 'image': Image.asset('images/Overflow Bottle Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Laptimer bracket', 'price': 'R250', 'image': Image.asset('images/Laptimer Bracket Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Velocity Gear Rack', 'price': 'R700', 'image': Image.asset('images/Gear Rack AMC (2).jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Apex Axle sliders', 'price': 'R950', 'image': Image.asset('images/Apex Axle Sliders Final.png'), 'color': '', 'isSelected': false,}
    ];
  }

  Future<void> _toggleSelection(Map<String, dynamic> product) async {
    if (currentUser == null) {
    _promptLogin();
    return;
  }
  
     await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailScreen(product: product, addToCart: _addToCart,),
    ),
  );
  
}
void _promptLogin() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Login Required'),
        content: const Text('Please log in to access your cart.'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Login'),
            onPressed: () {
              // Navigate to your login page or perform login logic
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              
            },
          ),
        ],
      );
    },
  );
}

  
void _goToCart() async {
  if (currentUser == null) {
    _promptLogin();
    return;
  }

  // Load the cart from Firestore
  List<Map<String, dynamic>> firestoreCartItems = await _loadCart();

  // Navigate to the CartPage with cart items and the removeFromCart function
  // ignore: use_build_context_synchronously
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return CartPage(
          cartItems: firestoreCartItems,
          removeFromCart: _removeFromCart,
        );
      },
    ),
  );
}


 // ignore: unused_element
 void _checkoutCart() async {
    // Getting the currently logged-in user
    final user = _auth.currentUser;
    if (user == null) {
      if (kDebugMode) {
        print('No user logged in!');
      }
      return;
    }

for (var item in cartItems) {
      await _firestore.collection('carts').add({
        'userId': user.uid, // Logged-in user's ID
        'product': item, // Product details
      });
    }
    
    // After successful checkout, clear the cart
    setState(() {
      cartItems.clear();
    });

    if (kDebugMode) {
      print('Checkout successful!');
    }
  }


void _addToCart(Map<String, dynamic> product) async {
   if (currentUser == null) {
    _promptLogin();
    return;
  }

  product.removeWhere((key, value) => value is Image);

  DocumentReference ref = await _firestore.collection('users').doc(currentUser!.uid).collection('cart').add(product);
  
  // Store the Firestore document ID in the product map
  product['id'] = ref.id;

  setState(() {
    cartItems.add(Map<String, dynamic>.from(product));
  });
}




void _removeFromCart(int index) async {
  if (kDebugMode) {
    print('Index: $index, Cart items length: ${cartItems.length}');
  }
  if (kDebugMode) {
    print('Start removing from cart');
  }
  
  // Check if the index is within bounds
  if (index < 0 || index >= cartItems.length) {
    if (kDebugMode) {
      print('Index out of bounds');
    }
    return;
  }

  // Print cart items for debugging
  if (kDebugMode) {
    print('Cart Items: $cartItems');
  }

  Map<String, dynamic> product = cartItems[index];
  if (kDebugMode) {
    print('Product to remove: ${product['id']}');
  }

  try {
    if (kDebugMode) {
      print('Deleting from Firestore');
    }
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('cart')
        .doc(product['id'])
        .delete();

    if (kDebugMode) {
      print('Deleted from Firestore');
    }

    setState(() {
      cartItems.removeAt(index);
    });
    if (kDebugMode) {
      print('Removed from local cart');
    }

    if (kDebugMode) {
      print('Document successfully removed from cart!');
    }
  } catch (error) {
    if (kDebugMode) {
      print('Failed to remove document from cart: $error');
    }
  }
}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _goToCart,
          ),
        ],
      ),
      body: Container(
        // Set background image using BoxDecoration
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/BackgroundShop.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 1200
                ? 4
                : MediaQuery.of(context).size.width > 800
                    ? 3 // Always show 3 items in a row for these widths
                    : MediaQuery.of(context).size.width > 600
                        ? 2
                        : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2, // Adjust the ratio to make items smaller
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return HoverCard(
              product: product,
              onTap: () => _toggleSelection(product),
              onColorChanged: (String color) {
                setState(() {
                  product['color'] = color;
        });
      },
    );
  },
),
      )
 );
  }
}

class HoverCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;
  final Function(String) onColorChanged;

  const HoverCard({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _toggleSelection() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        setState(() => _isHovering = true);
      },
      onExit: (_) {
        _controller.reverse();
        setState(() => _isHovering = false);
      },
      child: GestureDetector(
        onTap: _toggleSelection,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_isHovering ? 3.14 * _animation.value : 0),
          child: _isHovering && _animation.value > 0.5
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(3.14),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(widget.product['price'], style: const TextStyle(color: Colors.orange)),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: widget.onColorChanged,
                            decoration: const InputDecoration(
                              hintText: 'Enter colour',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: widget.onColorChanged,
                            decoration: const InputDecoration(
                              hintText: 'Enter your bike year and model',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: widget.product['isSelected']
                        ? Text(widget.product['name'])
                        : AspectRatio(
                            aspectRatio: 4 / 3,
                            child: widget.product['image'],
                          ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) addToCart;

  const ProductDetailScreen({Key? key, required this.product, required this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product['name']),
            const SizedBox(height: 10),
            Text(product['price']),
            const SizedBox(height: 10),
            Text(product['color']),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                addToCart(product);
                Navigator.pop(context);
                //List<Map<String, dynamic>> firestoreCartItems = await _loadCart();
              },
              child: const Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
Future<List<Map<String, dynamic>>> _loadCart() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId = auth.currentUser?.uid ?? 'defaultId';  // Get current user's id

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('cart').get();
  
  List<Map<String, dynamic>> firestoreCartItems = 
  querySnapshot.docs.map((doc) {
    // create a new map with the document id
    Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
    item['id'] = doc.id;
    return item;
  }).toList();

  return firestoreCartItems;
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int) removeFromCart;

  const CartPage({Key? key, required this.cartItems, required this.removeFromCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + double.parse(item['price'].substring(1)));
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['price']),
                      Text('Color: ${item['color']}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () => removeFromCart(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Price: R${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, 'checkout'),
        child: const Icon(Icons.check),
      ),
    );
  }
}
