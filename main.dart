import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/details': (context) => DetailsPage(),
      },
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final List<String> carTypes = ['Mercedes', 'BMW', 'Audi', 'Toyota', 'Honda', 'Ford'];
  final List<Map<String, String>> carDetails = [
    {'name': 'Mercedes A-Class', 'image': 'assets/mercedes.jpg'},
    {'name': 'BMW 3 Series', 'image': 'assets/bmw.jpg'},
// Add more car details here
  ];
  String selectedCarType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: carTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCarType = carTypes[index];
                    });
                  },
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(carTypes[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carDetails.length,
              itemBuilder: (context, index) {
                if (selectedCarType.isEmpty || carDetails[index]['name']!.contains(selectedCarType)) {
                  return Card(
                    child: ListTile(
                      leading: Hero(
                        tag: carDetails[index]['name']!,
                        child: Image.asset(carDetails[index]['image']!),
                      ),
                      title: Text(carDetails[index]['name']!),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: carDetails[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> car = ModalRoute.of(context)!.settings.arguments as Map<String,
        String>;
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']!),
      ),
      body: Column(
        children: [
          Hero(
            tag: car['name']!,
            child: Image.asset(car['image']!),
          ),
          SizedBox(height: 20),
          Text(
            car['name']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
// Add more car details here
        ],
      ),
    );
  }
}
