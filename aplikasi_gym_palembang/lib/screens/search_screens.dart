import 'package:aplikasi_gym_palembang/Models/Gym.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_gym_palembang/data/gym_data.dart';
import 'package:aplikasi_gym_palembang/Models/Gym.dart'; 
import 'package:aplikasi_gym_palembang/screens/detail_screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Variabel yang diperlukan
  List<Gym> _filteredGyms = gymList;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian Gym'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey[50],
              ),
              child: TextField(
                controller: _searchController, // Tambahkan controller
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                    _filteredGyms = gymList.where((gym) {
                      return gym.name.toLowerCase().contains(_searchQuery);
                    }).toList();
                  });
                },
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Cari Gym...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(

              itemCount: _filteredGyms.length,
              itemBuilder: (context, index) {
                final gym = _filteredGyms[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(gym: gym),
                      ),
                    );
                  },
                child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            gym.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gym.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(gym.location),
                        ],
                      ),
                    ],
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
