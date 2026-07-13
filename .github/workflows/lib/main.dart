import 'package:flutter/material.dart';

void main() => runApp(const SincanTakipApp());

class SincanTakipApp extends StatelessWidget {
  const SincanTakipApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sincan Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005EA6)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  final Map<String, String> _personelListesi = {
    'admin': 'sincan123',
    'serkantekbas': 'sincan06', 'fatihceylan': 'sincan06', 'muhammetduran': 'sincan06',
    'suayipgok': 'sincan06', 'yasinacikyer': 'sincan06', 'masumyagtu': 'sincan06',
    'ademyavuz': 'sincan06', 'abdullahmesutayhan': 'sincan06', 'emrecanakturk': 'sincan06',
    'yakupunlu': 'sincan06', 'mehmeteminerdem': 'sincan06', 'ismailalpergorpeli': 'sincan06',
    'turgutaydogdu': 'sincan06', 'memiseren': 'sincan06', 'omerfarukarslanturk': 'sincan06',
    'yunusemreacisu': 'sincan06', 'hasanhilmiergul': 'sincan06', 'semsettinceylan': 'sincan06',
    'ismetaltunay': 'sincan06', 'ahmetkaracam': 'sincan06',
  };

  void _login() {
    String user = _userController.text.trim().toLowerCase();
    String pass = _passController.text.trim();

    if (_personelListesi.containsKey(user) && _personelListesi[user] == pass) {
      if (user == 'admin') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPanelScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(username: user)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('HATA: Kullanıcı adı veya şifre yanlış!'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_city, size: 80, color: Color(0xFF005EA6)),
            const SizedBox(height: 10),
            const Text('SİNCAN BELEDİYESİ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF005EA6))),
            const Text('Online İş Takip Sistemi (30 Personel)', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 40),
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Kullanıcı Adı', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _passController, obscureText: true, decoration: const InputDecoration(labelText: 'Şifre', border: OutlineInputBorder())),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF005EA6), minimumSize: const Size(double.infinity, 50)),
              child: const Text('Giriş Yap', style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final String username;
  const MainScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sincan Takip Paneli'), backgroundColor: const Color(0xFF005EA6), iconTheme: const IconThemeData(color: Colors.white)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF005EA6)),
              child: Text('Sincan Belediyesi\nKullanıcı: ${username.toUpperCase()}', style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const ListTile(leading: Icon(Icons.play_arrow, color: Colors.green), title: Text('İşe Başlama (GPRS + Selfie)')),
            const ListTile(leading: Icon(Icons.date_range, color: Colors.blue), title: Text('Mazeret İzin Talebi')),
            const ListTile(leading: Icon(Icons.message, color: Colors.purple), title: Text('Yetkiliye Mesaj (Sohbet)')),
            const ListTile(leading: Icon(Icons.assignment, color: Colors.teal), title: Text('Görev Listesi')),
            const ListTile(leading: Icon(Icons.stop, color: Colors.red), title: Text('İş Bitiş (GPRS + Selfie)')),
          ],
        ),
      ),
      body: const Center(child: Text('Giriş Başarılı!\nİşlemler için sol menüyü kullanın.', textAlign: TextAlign.center)),
    );
  }
}

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SÜPER ADMİN TAKİP PANELİ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF005EA6),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('Canlı Personel Durumları (30 Personel)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF005EA6))),
          const SizedBox(height: 10),
          _buildLiveCard('Serkan Tekbaş', 'İşe Başladı (08:30)', 'Sincan Merkez Parkı', Colors.green),
          _buildLiveCard('Fatih Ceylan', 'Mazeret İzni İstiyor', 'Rapor Belgesi Eklendi', Colors.orange),
          _buildLiveCard('Muhammet Duran', 'İş Bitiş (17:00)', 'Belediye Ek Bina', Colors.red),
        ],
      ),
    );
  }

  Widget _buildLiveCard(String name, String status, String location, Color color) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, child: const Icon(Icons.person, color: Colors.white)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$status\nKonum: $location'),
        isThreeLine: true,
        trailing: const Icon(Icons.map, color: Color(0xFF005EA6)),
      ),
    );
  }
}
