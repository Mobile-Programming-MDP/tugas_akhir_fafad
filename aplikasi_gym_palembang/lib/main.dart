import 'package:flutter_ulung/screens/favorite_screen.dart';
import 'package:flutter_ulung/screens/home_screen.dart';
import 'package:flutter_ulung/screens/ProfileScreen.dart';
import 'package:flutter_ulung/screens/search_screen.dart';
import 'package:flutter_ulung/screens/SignInScreen.dart';
import 'package:flutter_ulung/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulung/screens/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State {
// TODO: 1. Deklarasikan variable
  int _currentIndex = 0;
  final List _children = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// TODO: 2. Buat properti body berupa widget yang ditampilkan
      body: _children[_currentIndex],
// TODO: 3. Buat properti bottomNavigationBar dengan nilai Theme
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple[50]),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.deepPurple,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.deepPurple,),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple,),
              label: 'Person',
            ),
          ],
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple[100],
          showUnselectedLabels: true,
        ),),
// TODO: 4. Buat data dan child dari Theme

    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wisata Candi',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.deepPurple),
              titleTextStyle: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
          ),
          colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            primary: Colors.deepPurple,
            surface: Colors.deepPurple[50],
          ),
          useMaterial3: true,
        ),
        home: SignUpScreen()
    );
  }
}