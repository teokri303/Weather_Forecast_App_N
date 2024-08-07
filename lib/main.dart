import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            Colors.blueGrey[50], // Background color of the app
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _weatherData = '';
  String _iconPath = '';
  bool _isLoading = false;

  String cityName = '';
  String country = '';
  String cond = '';
  String temp = '';

  Future<void> _fetchWeatherData() async {
    final city = _controller.text;
    if (city.isEmpty) return;

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=98b63ef055bac43032a198a85f645ceb&units=metric'; // Replace with actual API Key

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final condition = data['weather'][0]['main'];

        _iconPath = _getIconPath(condition);

        setState(() {
          cityName = data['name'];
          country = data['sys']['country'];
          cond = data['weather'][0]['main'];
          temp = "${data['main']['temp'].toInt()}";

          _isLoading = false;
        });
      } else {
        setState(() {
          _weatherData = 'Error: ${response.reasonPhrase}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Failed to load weather data: $e';
        _isLoading = false;
      });
    }
  }

  String _getIconPath(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/icons/clear.png';
      case 'clouds':
        return 'assets/icons/clouds.png';
      case 'drizzle':
        return 'assets/icons/drizzle.png';
      case 'humidity':
        return 'assets/icons/humidity.png';
      case 'mist':
        return 'assets/icons/mist.png';
      case 'rain':
        return 'assets/icons/rain.png';
      case 'snow':
        return 'assets/icons/snow.png';
      case 'wind':
        return 'assets/icons/wind.png';
      default:
        return 'assets/icons/clear.png';
    }
  }

  Color _getColorBasedOnTemperature(String temp) {
    int temperature;
    try {
      temperature = int.parse(temp); // Convert the string to an integer
    } catch (e) {
      print('FormatException: ${e.toString()}');
      temperature = 0; // Default value if parsing fails
    }
    if (temperature <= 0) {
      return Colors.blue[900]!; // Dark blue
    } else if (temperature <= 10) {
      return Colors.blue;
    } else if (temperature <= 20) {
      return Colors.lightBlue;
    } else if (temperature <= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = _getColorBasedOnTemperature(temp);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast App Narratologies'),
        backgroundColor: Colors.blueGrey[700], // Dark color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _iconPath.isNotEmpty
                        ? Image.asset(
                            _iconPath,
                            height: 200,
                            width: 200,
                          )
                        : Container(),
                    SizedBox(height: 10),
                    Text(
                      '$cityName $country',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: temp,
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          if (temp.isNotEmpty)
                            TextSpan(
                              text: '°C',
                              style: TextStyle(
                                fontSize:
                                    40, // Half the size of the temperature text
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      cond,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      _weatherData,
                      style: TextStyle(fontSize: 36, color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.blueGrey[600]),
              onPressed: _fetchWeatherData,
            ),
          ],
        ),
      ),
    );
  }
}
