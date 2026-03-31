import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(TikTokProApp());

class TikTokProApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black),
      ),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [VideoFeedScreen(), DiscoveryScreen(), Container(), InboxScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Keşfet"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Gelen"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// --- VİDEO AKIŞI (ANA SAYFA) ---
class VideoFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.black, child: Center(child: Icon(Icons.play_arrow, size: 80, color: Colors.white12))),
          Positioned(right: 15, bottom: 100, child: Column(children: [
            _actionIcon(Icons.favorite, "250K", Colors.red),
            _actionIcon(Icons.comment, "5.1K", Colors.white),
            _actionIcon(Icons.share, "Paylaş", Colors.white),
          ])),
          Positioned(left: 15, bottom: 30, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text("@tiktok_pro_erhan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(width: 10),
              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)), child: Text("Takip Et", style: TextStyle(fontSize: 12))),
            ]),
            SizedBox(height: 10),
            Text("PHP & Flutter ile Fullstack TikTok Pro altyapısı!"),
          ])),
        ],
      ),
    );
  }
  Widget _actionIcon(IconData icon, String label, Color color) => Padding(padding: EdgeInsets.only(bottom: 20), child: Column(children: [Icon(icon, size: 40, color: color), Text(label)]));
}

// --- KEŞFET SAYFASI ---
class DiscoveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(decoration: InputDecoration(hintText: "Ara...", prefixIcon: Icon(Icons.search), border: InputBorder.none))),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemBuilder: (context, index) => Container(color: Colors.grey[900], child: Icon(Icons.image, color: Colors.white24)),
      ),
    );
  }
}

// --- PROFİL SAYFASI (ÖZELLİK LİSTENDEN) ---
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 50)),
          SizedBox(height: 15),
          Text("@LO_Backend", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _stat("1.2M", "Takipçi"), _stat("450", "Takip"), _stat("10M", "Beğeni"),
          ]),
          SizedBox(height: 30),
          ElevatedButton(onPressed: () {}, child: Text("Profili Düzenle"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
        ],
      ),
    );
  }
  Widget _stat(String val, String label) => Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(val, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text(label)]));
}

class InboxScreen extends StatelessWidget { @override Widget build(BuildContext context) => Center(child: Text("Mesaj Kutusu Boş")); }
