import 'package:flutter/material.dart';
import 'package:aplikasi_gym_palembang/data/gym_data.dart';
import 'package:aplikasi_gym_palembang/Models/Gym.dart';
import 'package:aplikasi_gym_palembang/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  String _query = '';
  String _selectedType = 'Semua';

  List<String> get _types {
    final set = <String>{};
    for (final g in gymList) {
      set.add(g.type);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<Gym> get _filteredGyms {
    return gymList.where((g) {
      final matchQuery = _query.isEmpty ||
          g.name.toLowerCase().contains(_query.toLowerCase()) ||
          g.location.toLowerCase().contains(_query.toLowerCase());

      final matchType = _selectedType == 'Semua' || g.type == _selectedType;

      return matchQuery && matchType;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gyms = _filteredGyms;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ======= HEADER BERWARNA =======
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1F2937), // dark slate
                        Color(0xFF0F766E), // teal
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // teks kiri
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aplikasi Gym Palembang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Temukan gym terbaik • ${gymList.length} lokasi tersedia',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // quick badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_fire_department,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Rekomendasi Hari Ini',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // icon kanan
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                          ),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ======= SEARCH BAR =======
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.blueGrey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (v) => setState(() => _query = v.trim()),
                          decoration: const InputDecoration(
                            hintText: 'Cari gym / lokasi...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_query.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.close),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ======= CHIPS FILTER TYPE =======
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _types.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final t = _types[i];
                    final selected = t == _selectedType;

                    return ChoiceChip(
                      selected: selected,
                      label: Text(t),
                      onSelected: (_) => setState(() => _selectedType = t),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : Colors.blueGrey[700],
                      ),
                      selectedColor: const Color(0xFF2563EB),
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: selected
                              ? Colors.transparent
                              : Colors.blueGrey.withOpacity(0.15),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ======= GRID LIST =======
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final gym = gyms[index];

                    // Card wrapper untuk efek tap + rounded
                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        // kalau ItemCard kamu sudah handle navigasi sendiri, ini bisa dihapus
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: ItemCard(gym: gym),
                        ),
                      ),
                    );
                  },
                  childCount: gyms.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
