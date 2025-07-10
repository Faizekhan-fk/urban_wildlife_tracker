import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:urban_wildlife_tracker/screens/submit_screen.dart';
import 'package:urban_wildlife_tracker/screens/auth/login_screen.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  Position? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadSightings();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _loadSightings() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sightings')
          .orderBy('timestamp', descending: true)
          .limit(100)
          .get();

      List<Marker> markers = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        double? latitude = data['latitude']?.toDouble();
        double? longitude = data['longitude']?.toDouble();
        
        if (latitude != null && longitude != null) {
          markers.add(
            Marker(
              point: LatLng(latitude, longitude),
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(data['animal'] ?? 'Unknown Animal'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (data['notes'] != null && data['notes'].isNotEmpty)
                            Text(data['notes']),
                          if (data['imageUrl'] != null)
                            Image.network(
                              data['imageUrl'],
                              height: 200,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Image not available'),
                            ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
          );
        }
      }

      setState(() {
        _markers = markers;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading sightings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Urban Wildlife Tracker"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSightings,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition != null
                    ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                    : const LatLng(37.7749, -122.4194), // Default to San Francisco
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _markers,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmitScreen()),
          ).then((_) => _loadSightings()); // Refresh sightings when coming back
        },
        backgroundColor: Colors.green,
        tooltip: "Submit Sighting",
        child: const Icon(Icons.add),
      ),
    );
  }
}
