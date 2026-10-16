import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String role;

  const HomeScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.role,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Product> _products = [
    Product(
      title: 'Latte',
      description: 'A smooth coffee drink made with espresso and a large amount of steamed milk, topped with a thin layer of foam.',
      imagePath: 'assets/latte_img.jpg',
      price: '1 200₸',
      options: ['Hot', 'Cold', 'Sugar', 'Syrups', 'Cinnamon'],
      rating: 4.5,
    ),
    Product(
      title: 'Americano',
      description: 'A coffee drink made by pouring hot water over one shot of espresso.',
      imagePath: 'assets/americano_img.jpg',
      price: '650₸',
      options: ['Hot', 'Cold', 'Extra Shot'],
      rating: 4.8,
    ),
    Product(
      title: 'Affogato',
      description: 'A scoop of cold vanilla ice cream drowned with a hot, freshly pulled shot of espresso.',
      imagePath: 'assets/affogato_img.jpg',
      price: '1 500₸',
      options: ['Extra Ice Cream', 'Chocolate Drizzle'],
      rating: 4.7,
    ),
    Product(
      title: 'Mocha',
      description: 'A sweet, chocolate-flavored variant of a latte made by combining espresso, chocolate, and steamed milk',
      imagePath: 'assets/mocha_img.jpg',
      price: '1 300₸',
      options: ['Hot', 'Cold', 'Extra Chocolate', 'Whipped Cream'],
      rating: 4.9,
    ),
  ];

@override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(product.imagePath, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text('${product.price} • Rating: ${product.rating} ⭐'),
              ),
              trailing: IconButton(
                icon: Icon(product.isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: Colors.brown),
                onPressed: () {
                  setState(() {
                    product.isBookmarked = !product.isBookmarked;
                  });
                },
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
                setState(() {});
              },
            ),
          );
        },
      ),

      Builder(
        builder: (context) {
          final bookmarkedItems = _products.where((p) => p.isBookmarked).toList();
          if (bookmarkedItems.isEmpty) {
            return const Center(
              child: Text(
                'No favorite items yet!\nTap the bookmark icon on items.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookmarkedItems.length,
            itemBuilder: (context, index) {
              final product = bookmarkedItems[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(product.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(product.price),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
                    );
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),

      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.brown, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 16),
            Text(widget.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.email, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 16),
            Chip(label: Text('Role: ${widget.role}')),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
              onPressed: () {
                // Return back to registration screen and clear route stack
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Coffee Feed' : _currentIndex == 1 ? 'Favorites' : 'User Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF613A28),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}