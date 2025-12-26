import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aplikasi_gym_palembang/Models/Gym.dart';
import 'package:aplikasi_gym_palembang/data/gym_data.dart';
import 'package:aplikasi_gym_palembang/screens/detail_screens.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Gym> _favoriteGyms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil hanya gym yang status favoritnya true di SharedPreferences
    final favorites = gymList.where((gym) {
      final key = 'favorite_${gym.name}';
      return prefs.getBool(key) ?? false;
    }).toList();

    if (!mounted) return;
    setState(() {
      _favoriteGyms = favorites;
      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(Gym gym) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'favorite_${gym.name}';

    await prefs.setBool(key, false);

    if (!mounted) return;
    setState(() {
      _favoriteGyms.removeWhere((g) => g.name == gym.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFavorites,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteGyms.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada gym favorit.\nTambahkan dari halaman detail.',
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadFavorites,
                  child: ListView.builder(
                    itemCount: _favoriteGyms.length,
                    itemBuilder: (context, index) {
                      final gym = _favoriteGyms[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              gym.imageAsset,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            gym.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(gym.location),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () => _removeFavorite(gym),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(gym: gym),
                              ),
                            );
                            // Setelah balik dari detail, refresh list favorit
                            _loadFavorites();
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
