import 'package:flutter/material.dart';
import 'qibla_screen.dart';
import 'prayer_times_screen.dart';

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
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QiblaScreen()),
                );
              },
              icon: const Icon(Icons.explore),
              label: const Text("Arah Qiblat"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrayerTimesScreen()),
                );
              },
              icon: const Icon(Icons.access_time),
              label: const Text("Waktu Solat"),
            ),
          ],
        ),
      ),
    );
  }
}
