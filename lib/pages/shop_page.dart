// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      {'name': 'Motard Front Axle sliders', 'price': 'R400', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders', 'price': 'R400', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Overflow bottle (vented or unvented)', 'price': 'R250', 'image': Image.asset('images/Overflow Bottle Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Laptimer bracket', 'price': 'R250', 'image': Image.asset('images/Laptimer Bracket Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Velocity Gear Rack', 'price': 'R700', 'image': Image.asset('images/Gear Rack AMC (2).jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Apex Axle sliders', 'price': 'R950', 'image': Image.asset('images/Apex Axle Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Front Axle sliders PUKS ONLY', 'price': 'R250', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders PUKS ONLY', 'price': 'R200', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders', 'price': 'R450', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders PUKS ONLY', 'price': 'R300', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,}
    ];

      products1 = [
      {'name': 'Motard Front Axle sliders', 'price': 'R400 (R250 puks only)', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders', 'price': 'R400 (R200 puks only)', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Laptimer Bracket', 'price': 'R250', 'image': Image.asset('images/Overflow Bottle Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Overflow bottle (vented or unvented)', 'price': 'R250', 'image': Image.asset('images/Laptimer Bracket Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Velocity Gear Rack', 'price': 'R700', 'image': Image.asset('images/Gear Rack AMC (2).jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Apex Axle sliders', 'price': 'R950', 'image': Image.asset('images/Apex Axle Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Front Axle sliders PUKS', 'price': 'R250', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Footpeg sliders PUKS ONLY', 'price': 'R200', 'image': Image.asset('images/Footpeg Sliders Final.png'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders', 'price': 'R450', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,},
      {'name': 'Motard Rear Axle sliders PUKS ONLY', 'price': 'R300', 'image': Image.asset('images/Front Bobbin AMC.jpeg'), 'color': '', 'isSelected': false,}
    ];
  }

  Future<void> _toggleSelection(Map<String, dynamic> product) async {
   await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product, addToCart: _addToCart,),
      ),
    );
  }

  
void _goToCart() async {
  // Load the cart from Firestore
  List<Map<String, dynamic>> firestoreCartItems = await _loadCart();

  // Update the state
  setState(() {
    cartItems = firestoreCartItems;
  });

  // Navigate to the CartPage
  // ignore: use_build_context_synchronously
await Navigator.of(context).push(
  MaterialPageRoute(
    builder: (BuildContext context) {
      return CartPage(
        cartItems: cartItems,
        removeFromCart: _removeFromCart,  // Ensure this is correctly initialized
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
  product.removeWhere((key, value) => value is Image);

  DocumentReference ref = await _firestore.collection('users').doc(currentUser!.uid).collection('cart').add(product);
  
  // Store the Firestore document ID in the product map
  product['id'] = ref.id;

  setState(() {
    cartItems.add(Map<String, dynamic>.from(product));
  });
}




void _removeFromCart(int index) async {
  // Get the product from the cartItems list
  Map<String, dynamic> product = cartItems[index];
  if (kDebugMode) {
    print('Removing product with ID: ${product['id']}');
  }

  // Use the stored document ID to delete the document from Firestore
  _firestore.collection('users').doc(currentUser!.uid).collection('cart').doc(product['id']).delete().then((value) {
    if (kDebugMode) {
      print('Document successfully removed!');
    }

    // Update the state after successfully removing the document from Firestore
    setState(() {
      cartItems.removeAt(index);
    });
  }).catchError((error) {
    if (kDebugMode) {
      print('Failed to remove document: $error');
    } 
  });
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
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 4 / 3,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.product['name']),
                        const SizedBox(height: 10),
                        Text(widget.product['price']),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: widget.onColorChanged,
                          decoration: const InputDecoration(
                            hintText: 'Enter colour',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          onChanged: widget.onColorChanged,
                          decoration: const InputDecoration(
                            hintText: 'Enter mini if you would like this for the Mini Motard',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Card(
                  child: widget.product['isSelected']
                      ? Text(widget.product['name'])
                      : AspectRatio(
                          aspectRatio: 4 / 3, // You can adjust this value based on your preference.
                          child: widget.product['image'],
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('Color: ${item['color']}'),
           trailing: IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () => removeFromCart(index),
          ),

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, 'checkout'),
        child: const Icon(Icons.check),
      ),
    );
  }
}