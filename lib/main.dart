import 'package:flutter/material.dart';
import 'home_page.dart';
import 'popular_page.dart';
import 'category_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKT Trans Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    PopularPage(),
    CategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Populer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Kategori',
          ),
        ],
      ),
    );
  }
}

// Model data mobil 
class Car {
  final String name;
  final String brand;
  final String image;
  final int price;
  final double rating;
  final String category;
  final int seats;         
  final String transmission; 
  final String fuel;       
  final int year;

  Car({
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.rating,
    required this.category,
    required this.seats,
    required this.transmission,
    required this.fuel,
    required this.year,
  });
}

// Data dummy mobil 
final List<Car> cars = [
  // 1. ELF Long
  Car(
    name: 'ELF Long',
    brand: 'Isuzu',
    image: 'https://rentalmobilterdekat.com/wp-content/uploads/2023/01/478-Foto-By-Bali-Jaya-Trans-1.jpg',
    price: 1500000,
    rating: 4.7,
    category: 'Bus',
    seats: 19,
    transmission: 'Manual',
    fuel: 'Solar',
    year: 2024,
  ),
  
  // 2. Medium Bus
  Car(
    name: 'Medium Bus',
    brand: 'Mercedes-Benz',
    image: 'https://th.bing.com/th/id/OIP.9zpHFOGBNWRoAf2mEE7tEgHaE8?w=251&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 2500000,
    rating: 4.8,
    category: 'Bus',
    seats: 31,
    transmission: 'Manual',
    fuel: 'Solar',
    year: 2025,
  ),
  
  // 3. Hiace Commuter
  Car(
    name: 'Hiace Commuter',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.yOZV9WRYbVMVZsjcHheYygHaEK?w=296&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 1800000,
    rating: 4.9,
    category: 'Minibus',
    seats: 14,
    transmission: 'Manual',
    fuel: 'Diesel',
    year: 2024,
  ),
  
  // 4. Hiace Premio
  Car(
    name: 'Hiace Premio',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.iVdSLudUxDh2e_bevDLCQQHaE8?w=253&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 2200000,
    rating: 4.9,
    category: 'Minibus',
    seats: 12,
    transmission: 'Automatic',
    fuel: 'Diesel',
    year: 2026,
  ),
  
  // 5. ELF Short
  Car(
    name: 'ELF Short',
    brand: 'Isuzu',
    image: 'https://tse2.mm.bing.net/th/id/OIP.bJoKIOhX-P4pS9KAyxdqFwHaFj?w=860&h=645&rs=1&pid=ImgDetMain&o=7&rm=3',
    price: 1200000,
    rating: 4.6,
    category: 'Bus',
    seats: 16,
    transmission: 'Manual',
    fuel: 'Solar',
    year: 2022,
  ),
  
  // 6. Hiace Luxury 
  Car(
    name: 'Hiace Luxury',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.8I1yA0Dtde5vUIiZFlqkxgHaEK?w=311&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 2800000,
    rating: 5.0,
    category: 'Minibus',
    seats: 9,
    transmission: 'Automatic',
    fuel: 'Diesel',
    year: 2023,
  ),
  
  // 7. Innova Reborn
  Car(
    name: 'Innova Reborn',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.uxvH3hOindZVVQDVhZOqZAHaEK?w=316&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 850000,
    rating: 4.8,
    category: 'MPV',
    seats: 7,
    transmission: 'Manual',
    fuel: 'solar',
    year: 2022,
  ),
  
  // 8. Innova Zenix
  Car(
    name: 'Innova Zenix',
    brand: 'Toyota',
    image: 'https://tse4.mm.bing.net/th/id/OIP.KNVmRvtkZZic903bNddhfgHaFD?pid=ImgDet&w=187&h=127&c=7&dpr=1,3&o=7&rm=3',
    price: 950000,
    rating: 4.9,
    category: 'MPV',
    seats: 7,
    transmission: 'Automatic',
    fuel: 'Bensin',
    year: 2025,
  ),
  
  // 9. Avanza
  Car(
    name: 'Avanza',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.Cd-h6mL3cxT_0vHdSb3iGwHaEZ?w=338&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 550000,
    rating: 4.6,
    category: 'MPV',
    seats: 7,
    transmission: 'Manual',
    fuel: 'Bensin',
    year: 2023,
  ),
  
  // 10. Avanza Veloz
  Car(
    name: 'Avanza Veloz',
    brand: 'Toyota',
    image: 'https://th.bing.com/th/id/OIP.gvUEVBEgcsaDWVJG6sgvbAHaE8?w=267&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 650000,
    rating: 4.7,
    category: 'MPV',
    seats: 7,
    transmission: 'Automatic',
    fuel: 'Bensin',
    year: 2024,
  ),
  
  // 11. Xpander
  Car(
    name: 'Xpander',
    brand: 'Mitsubishi',
    image: 'https://tse1.mm.bing.net/th/id/OIP.92X_v1JKwPsCKZV7-U751QHaEK?pid=ImgDet&w=184&h=103&c=7&dpr=1,3&o=7&rm=3',
    price: 600000,
    rating: 4.7,
    category: 'MPV',
    seats: 7,
    transmission: 'Manual',
    fuel: 'Bensin',
    year: 2022,
  ),
  
  // 12. Ertiga 
  Car(
    name: 'Ertiga',
    brand: 'Suzuki',
    image: 'https://th.bing.com/th/id/OIP.wtqLD_IstNYDwSebuduCrAHaEK?w=292&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
    price: 700000,
    rating: 4.8,
    category: 'MPV',
    seats: 7,
    transmission: 'Automatic',
    fuel: 'Bensin',
    year: 2023,
  ),
];