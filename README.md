Weather App

A simple weather application built with Flutter that allows users to search for weather information by city name, view weather conditions, and manage a list of favorite cities. The app fetches weather data from the OpenWeather API and provides a visually appealing user interface with dynamic backgrounds and icons based on weather conditions.

Table of Contents

Features
Setup
Running the App
Design Decisions
Features

Search for weather information by city name.
Display current weather conditions including temperature, weather type, and location.
Dynamic weather icons and background based on the current weather conditions.
Add or remove cities from a favorites list.
Navigate to a dedicated favorites page to view and select favorite cities.
Setup

Prerequisites
Flutter SDK installed on your machine.
An IDE like Android Studio or Visual Studio Code with the Flutter and Dart plugins.
An API key from OpenWeather.
Instructions
Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/weather-app.git
cd weather-app
Install Dependencies
Navigate to the project directory and run:

bash
Copy code
flutter pub get
Configure API Key
Replace the placeholder API key in the code with your own from OpenWeather. The key can be found in \_fetchWeatherData method inside WeatherHomePage:

dart
Copy code
final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric';
Run the App
Connect a physical device or start an emulator, then run:

bash
Copy code
flutter run
The app should build and deploy to your device or emulator.
Running the App

Open your terminal or use the terminal integrated into your IDE.
Ensure your device or emulator is connected and ready.
Use the command flutter run to build and launch the app.
Interact with the app to search for weather by entering a city name, manage favorite cities, and view dynamic weather information.
Design Decisions

1. State Management
   The app uses setState for managing the UI's reactive state, which is sufficient for the current scope of the app. Given the simple nature of the app, a more complex state management solution like Provider or Riverpod was not deemed necessary.

2. Dynamic UI Elements
   The app dynamically changes its background and weather icons based on the current weather conditions. This was implemented to provide a more engaging user experience. The \_getBackgroundPath and \_getIconPath methods handle these visual changes.

3. Favorites Management
   The favorites functionality allows users to add or remove cities from a list of favorite locations. The list is stored locally in memory, as persistence was not required. The user can navigate to a dedicated page (FavoritesPage) to view and select favorite cities.

4. API Integration
   The app integrates with the OpenWeather API to fetch live weather data. Error handling is included to manage cases where the API call fails or the user enters an invalid city name. The API key is hardcoded for simplicity, but in a production app, it would be better to secure this key using environment variables or a secure storage solution.

5. Visual Design
   Color Scheme: The app uses a soft blue-grey background color to create a calming and neutral starting point. The temperature text color changes dynamically based on the temperature range, providing a visual cue to the user.
   Iconography: Weather icons are chosen to be clear and visually representative of common weather conditions.
   Background GIFs: Animated backgrounds were chosen to make the app feel more interactive and alive, reflecting the current weather in a visually compelling way.
