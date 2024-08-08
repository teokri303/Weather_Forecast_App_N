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
  bool _hasError = false;
  bool _isFavorite = false;

  String cityName = '';
  String country = '';
  String cond = '';
  String temp = '';

  List<String> _favoriteCities = [];

  Future<void> _fetchWeatherData() async {
    _weatherData = '';
    final city = _controller.text.trim();
    if (city.isEmpty) return;

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=98b63ef055bac43032a198a85f645ceb&units=metric'; // Replace with actual API Key

    setState(() {
      _isLoading = true;
      _hasError = false;
      _weatherData = ''; // Clear weather data
      _iconPath = ''; // Clear icon path
      _isFavorite = false;
      cityName = ''; // Clear city name
      country = ''; // Clear country
      cond = ''; // Clear condition
      temp = ''; // Clear temperature
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

          // Update the _isFavorite state based on whether the city is in the favorites list
          _isFavorite = _favoriteCities.contains(city);

          _isLoading = false;
        });
      } else {
        setState(() {
          _weatherData = 'Given city ${response.reasonPhrase}. \n Try again.';
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Failed to load weather data: $e';
        _isLoading = false;
        _hasError = true;
      });
    }
  }

//weather icon
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
      case 'thunderstorm':
        return 'assets/icons/rain.png';
      default:
        return 'assets/icons/clear.png';
    }
  }

//temperature color
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

//background gifs
  String _getBackgroundPath(String condition) {
    if (_hasError) {
      return 'assets/gifs/error.jpeg'; // Path to error GIF
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/gifs/clear_sky.gif';
      case 'clouds':
        return 'assets/gifs/clouds.gif';
      case 'drizzle':
        return 'assets/gifs/clouds.gif'; // Assuming drizzle has its own GIF
      case 'rain':
        return 'assets/gifs/rain.gif';
      case 'snow':
        return 'assets/gifs/snow.gif';
      case 'mist':
        return 'assets/gifs/wind.gif';
      case 'thunderstorm':
        return 'assets/gifs/rain.gif';
      default:
        return 'assets/icons/first.gif'; // Default background if condition is not recognized
    }
  }

  void _addToFavorites() {
    final city = _controller.text.trim(); // Trim whitespace
    if (city.isNotEmpty) {
      setState(() {
        if (_favoriteCities.contains(city)) {
          // If the city is already in the favorites list, remove it
          _favoriteCities.remove(city);
        } else {
          // If the city is not in the favorites list, add it
          _favoriteCities.add(city);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = _getColorBasedOnTemperature(temp);
    String backgroundPath = _getBackgroundPath(
        cond); // Get the path for the current weather condition

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background GIF
          Image.asset(
            backgroundPath,
            fit: BoxFit.cover,
          ),
          // Foreground content

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Discover Today's Weather",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildSearchBar(),
                SizedBox(height: 10),
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
                                height: 180,
                                width: 180,
                              )
                            : Container(),
                        Text(
                          '$cityName $country',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: temp,
                                style: TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                ),
                              ),
                              if (temp.isNotEmpty)
                                TextSpan(
                                  text: '°C',
                                  style: TextStyle(
                                    fontSize:
                                        20, // Half the size of the temperature text
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _weatherData,
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritesPage(
                                  favoriteCities: _favoriteCities,
                                  onCitySelected: (city) {
                                    _controller.text = city;
                                    _fetchWeatherData();
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('View Favorite Citys'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: double.infinity, // Allows the container to take full width
        padding: EdgeInsets.symmetric(
            horizontal: 16), // Add padding for some spacing
        child: Wrap(
          spacing: 10, // Spacing between items
          runSpacing: 10, // Spacing between rows
          alignment: WrapAlignment.center, // Align items in the center
          children: [
            Container(
              constraints:
                  BoxConstraints(maxWidth: 300), // Max width of the search bar
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
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.white, // Background color
              ),
              child: Icon(Icons.search, color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () {
                _addToFavorites();
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.white, // Background color
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteCities;
  final Function(String) onCitySelected;

  FavoritesPage({required this.favoriteCities, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cities'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background GIF
          Positioned.fill(
            child: Image.asset(
              'assets/gifs/clear_sky.gif', // Replace with your GIF path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: favoriteCities.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5, // Add shadow for a more elevated look
                  child: ListTile(
                    title: Center(
                      child: Text(
                        favoriteCities[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      onCitySelected(favoriteCities[index]);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
