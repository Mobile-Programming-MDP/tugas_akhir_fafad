import 'package:flutter_ulung/data/candi_data.dart';
import 'package:flutter_ulung/models/candi.dart';
import 'package:flutter_ulung/widgets/item_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
// TODO: 1. Buat appbar dengan judul Wisata Candi
        appBar: AppBar(title: Text('Wisata Candi')),
// TODO: 2. Buat body dengan GridView.builder
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: candiList.length,
          itemBuilder: (context,index) {
            Candi candi = candiList[index];
            return ItemCard(candi: candi);
          },)
// TODO: 3. Buat ItemCard sebagai return value dari GridView.Builder
    );
  }
}