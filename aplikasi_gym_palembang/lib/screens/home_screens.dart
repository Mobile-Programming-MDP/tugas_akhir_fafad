import 'package:aplikasi_gym_palembang/Models/Gym.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_gym_palembang/data/gym_data.dart';
import 'package:aplikasi_gym_palembang/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Gym'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(8.0),
        itemCount: gymList.length,
        itemBuilder: (context, index) {
          Gym gym = gymList[index];
          return ItemCard(gym: gym);
        },
      ),
    );
  }
}
