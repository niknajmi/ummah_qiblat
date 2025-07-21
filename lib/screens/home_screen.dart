import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ummah Qiblat by A. Najmi'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Selamat Datang ke Ummah Qiblat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Fungsi akan ditambah:'),
            Text('- Arah Qiblat'),
            Text('- Waktu Solat + Notifikasi'),
            Text('- Hadis & Motivasi Harian'),
            Text('- Tarikh Hijri + Lokasi'),
          ],
        ),
      ),
    );
  }
}
