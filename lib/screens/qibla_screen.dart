import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double qiblaDirection = 292; // Contoh Qiblat Malaysia ~292° dari Utara

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arah Qiblat"),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<double?>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Sensor kompas tidak tersedia");
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            double direction = snapshot.data ?? 0;
            double angle = (qiblaDirection - direction) * (math.pi / 180);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -angle,
                  child: Image.asset(
                    'assets/compass.png',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Halakan telefon sehingga jarum menghadap Qiblat",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
