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

  // 👥 30 PERSONELİN GİRİŞ LİSTESİ
  final Map<String, String> _personelListesi = {
    'admin': 'sincan123',
    'serkantekbas': 'sincan06', 'fatihceylan': 'sincan06', 'muhammetduran': 'sincan06',
    'suayipgok': 'sincan06', 'yasinacikyer': 'sincan06', 'masumyagtu': 'sincan06',
    'ademyavuz': 'sincan06', 'abdullahmesutayhan': 'sincan06', 'emrecanakturk': 'sincan06',
    'yakupunlu': 'sincan06', 'mehmeteminerdem': 'sincan06', 'ismailalpergorpeli': 'sincan06',
    'turgutaydogdu': 'sincan06', 'memiseren': 'sincan06', 'omerfarukarslanturk': 'sincan06',
    'yunusemreacisu': 'sincan06', 'hasanhilmiergul': 'sincan06', 'semsettinceylan': 'sincan06',
    'ismetaltunay': 'sincan06', 'ahmetkaracam': 'sincan06',
    'personel21': 'sincan06', 'personel22': 'sincan06', 'personel23': 'sincan06',
    'personel24': 'sincan06', 'personel25': 'sincan06', 'personel26': 'sincan06',
    'personel27': 'sicnan06', 'personel28': 'sincan06', 'personel29': 'sincan06',
    'personel30': 'sincan06',
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
            ListTile(
              leading: const Icon(Icons.play_arrow, color: Colors.green), 
              title: const Text('İşe Başlama (GPRS + Selfie)'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('İşe Başlama Başarılı! Konum ve Kamera Aktif.'), backgroundColor: Colors.green));
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.blue), 
              title: const Text('Mazeret İzin Talebi'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MazeretScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.message, color: Colors.purple), 
              title: const Text('Yetkiliye Mesaj (Sohbet)'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment, color: Colors.teal), 
              title: const Text('Görev Listesi'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TasksScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.stop, color: Colors.red), 
              title: const Text('İş Bitiş (GPRS + Selfie)'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mesai Bitirildi! Çıkış Saati Kaydedildi.'), backgroundColor: Colors.red));
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Giriş Başarılı!\nİşlemler için sol menüyü kullanın.', textAlign: TextAlign.center)),
    );
  }
}

class MazeretScreen extends StatelessWidget {
  const MazeretScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mazeret İzin Formu'), backgroundColor: const Color(0xFF005EA6), iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Mazeret Nedeni', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Dosya/Rapor Fotoğrafı Ekle')),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF005EA6)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mazeret Talebiniz İletildi!'), backgroundColor: Colors.green));
                Navigator.pop(context);
              },
              child: const Text('Talebi Gönder', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yetkili İletişim Merkezi'), backgroundColor: const Color(0xFF005EA6), iconTheme: const IconThemeData(color: Colors.white)),
      body: Column(
        children: [
          Expanded(child: ListView(children: const [ListTile(title: Text('Yönetici:'), subtitle: Text('Lütfen iş durumunuzu güncel tutun.'))])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Mesajınızı yazın...', border: OutlineInputBorder()))),
                IconButton(icon: const Icon(Icons.send, color: Color(0xFF005EA6)), onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Görev Listesi'), backgroundColor: const Color(0xFF005EA6), iconTheme: const IconThemeData(color: Colors.white)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          Card(child: ListTile(title: Text('Haftalık Görev: Saha Kontrolü'), subtitle: Text('Sincan Merkez Bölgesi Taraması'), trailing: Text('Bekliyor', style: TextStyle(color: Colors.orange)))),
          Card(child: ListTile(title: Text('Günlük Görev: Raporlama'), subtitle: Text('Akşam mesai bitimi evrak teslimi'), trailing: Text('Tamamlandı', style: TextStyle(color: Colors.green))))
        ],
      ),
    );
  }
}

// 🏛️ SADECE SİZİN GÖRECEĞİNİZ CANLI YÖNETİCİ TAKİP EKRANI (ADMIN PANEL)
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SÜPER ADMİN TAKİP PANELİ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF005EA6),
