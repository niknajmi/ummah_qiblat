
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:async';

void main() {
  runApp(const UmmahQiblatApp());
}

class UmmahQiblatApp extends StatelessWidget {
  const UmmahQiblatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ummah Qiblat',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const UmmahQiblatHome(),
    );
  }
}

class UmmahQiblatHome extends StatefulWidget {
  const UmmahQiblatHome({super.key});

  @override
  State<UmmahQiblatHome> createState() => _UmmahQiblatHomeState();
}

class _UmmahQiblatHomeState extends State<UmmahQiblatHome> {
  double? qiblahDirection;
  String location = "Loading...";
  String hijriDate = "";
  String motivation = "Sabar adalah separuh daripada iman.";
  String hadis = "“Sesungguhnya Allah tidak melihat rupa kamu, tetapi melihat hati dan amalan kamu.” (HR Muslim)";
  PrayerTimes? prayerTimes;
  final Coordinates _coords = Coordinates(0, 0);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position pos = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      location = "${placemarks.first.locality}, ${placemarks.first.country}";
      HijriCalendar.setLocal("ar");
      hijriDate = HijriCalendar.now().toFormat("dd MMMM yyyy");
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.shafi;
      prayerTimes = PrayerTimes(Coordinates(pos.latitude, pos.longitude), DateTime.now(), params);
    });

    FlutterQiblah.qiblahStream.listen((qiblah) {
      setState(() {
        qiblahDirection = qiblah.qiblah;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ummah Qiblat")),
      body: prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Lokasi Semasa: $location", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Tarikh Hijri: $hijriDate", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text("Arah Kiblat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(qiblahDirection != null ? "Sudut: ${qiblahDirection!.toStringAsFixed(2)}°" : "Mengira..."),
                  const Divider(),
                  const Text("Waktu Solat Hari Ini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Subuh: ${prayerTimes!.fajr}"),
                  Text("Zohor: ${prayerTimes!.dhuhr}"),
                  Text("Asar: ${prayerTimes!.asr}"),
                  Text("Maghrib: ${prayerTimes!.maghrib}"),
                  Text("Isyak: ${prayerTimes!.isha}"),
                  const Divider(),
                  const Text("Hadis Hari Ini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(hadis, textAlign: TextAlign.center),
                  const Divider(),
                  const Text("Motivasi Hari Ini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(motivation, textAlign: TextAlign.center),
                ],
              ),
            ),
    );
  }
}
