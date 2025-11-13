// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../utils/theme_provider.dart';
import '../welcome_input_screen.dart';
import 'utils/weather_model.dart';
import 'utils/weather_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? indexNumber;
  double? latitude;
  double? longitude;
  bool isDarkMode = false;
  Weather? currentWeather;

  bool isLoadingWeather = false;
  bool isOffline = false;
  String? apiUrl;

  late final Connectivity _connectivity;
  late final Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _initializeData();
    _listenConnectivity();
  }

  void _listenConnectivity() {
    _connectivityStream.listen((resultList) {
      final currentlyOffline = resultList.contains(ConnectivityResult.none);
      if (currentlyOffline != isOffline) {
        setState(() => isOffline = currentlyOffline);
        if (isOffline) {
          _showOfflineBanner();
        } else {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          _fetchWeather();
        }
      }
    });
  }

  void _showOfflineBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(
          "You're offline",
          style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.red,
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Text(
              'DISMISS',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getString('index_number');
    final savedTheme = prefs.getBool('is_dark_mode') ?? false;

    final lastWeather = prefs.getString('lastWeather');
    if (lastWeather != null) {
      currentWeather = Weather.fromJson(jsonDecode(lastWeather));
    }

    if (savedIndex != null && savedIndex.length >= 4) {
      final firstTwo = int.tryParse(savedIndex.substring(0, 2)) ?? 0;
      final nextTwo = int.tryParse(savedIndex.substring(2, 4)) ?? 0;

      setState(() {
        indexNumber = savedIndex;
        latitude = 5 + (firstTwo / 10.0);
        longitude = 79 + (nextTwo / 10.0);
        isDarkMode = savedTheme;
      });
      _fetchWeather();
    } else {
      setState(() => isDarkMode = savedTheme);
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('index_number');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeInputScreen()),
    );
  }

  Future<void> _fetchWeather() async {
    if (latitude == null || longitude == null) return;

    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() => isOffline = true);
      _showOfflineBanner();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("You're offline")));
      return;
    } else {
      setState(() {
        isOffline = false;
        isLoadingWeather = true;
      });
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    }

    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m';
    apiUrl = url;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['current'];
        currentWeather = Weather(
          temperature: (data['temperature_2m'] as num).toDouble(),
          weatherCode: data['weather_code'],
          windSpeed: (data['wind_speed_10m'] as num).toDouble(),
          humidity: (data['relative_humidity_2m'] as num).toDouble(),
          fetchedAt: DateTime.now(),
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'lastWeather',
          jsonEncode(currentWeather!.toJson()),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Error fetching weather")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error fetching weather")));
    } finally {
      setState(() => isLoadingWeather = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              indexNumber ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: (indexNumber == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: buildInfoCard(
                            context,
                            'Latitude',
                            latitude?.toStringAsFixed(2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: buildInfoCard(
                            context,
                            'Longitude',
                            longitude?.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (currentWeather != null)
                      buildWeatherCard(context, currentWeather!),
                    const SizedBox(height: 32),
                    if (apiUrl != null)
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF4F4F4F)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'API URL: $apiUrl',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.cloud),
                        label: Text(
                          isLoadingWeather
                              ? 'Fetching...'
                              : 'Get Current Weather',
                        ),
                        onPressed: isLoadingWeather ? null : _fetchWeather,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
