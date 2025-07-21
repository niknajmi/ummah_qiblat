import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Waktu solat manual sementara
    Map<String, String> prayerTimes = {
      "Subuh": "05:45",
      "Zohor": "13:10",
      "Asar": "16:30",
      "Maghrib": "19:25",
      "Isyak": "20:40",
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Waktu Solat"),
        centerTitle: true,
      ),
      body: ListView(
        children: prayerTimes.entries.map((entry) {
          return ListTile(
            leading: const Icon(Icons.access_time, color: Colors.green),
            title: Text(entry.key),
            trailing: Text(
              entry.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }
}
