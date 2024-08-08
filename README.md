# Weather App

## Overview

This is a simple Flutter-based Weather App that fetches current weather data for a given city using the OpenWeatherMap API. The app features a clean and intuitive UI, allowing users to search for weather information, view the current weather conditions, and save their favorite cities for easy access.

## Features

- **Weather Search:** Users can enter a city name to get real-time weather data including temperature, weather condition, and an appropriate weather icon.
- **Favorites Management:** Users can save their favorite cities and easily switch between them to check the weather.
- **Dynamic Background and Icon:** The app displays dynamic backgrounds and icons based on the current weather condition.
- **Responsive UI:** The app is designed to work smoothly on different screen sizes with a responsive layout.

## Installation

1. **Clone the Repository**
   ```sh
   git clone https://github.com/your-username/weather-app.git
   ```
2. **Navigate to the Project Directory**

   ```sh
   cd weather-app
   ```

3. **Install Depedencies**
   ```sh
   flutter pub get
   ```
4. **Run the App**
   ```sh
   flutter run
   ```

## API KEY

This app uses the OpenWeatherMap API to fetch weather data. Replace the API key in the code with your own to avoid reaching the API request limit.

**Run the App**

```dart
flutter run
```

You can obtain an API key by signing up at OpenWeatherMap.

## Features

1. **Search for a City:**

   - Enter a city name in the search bar and press the search icon to fetch the weather data.

2. **Add to Favorites:**

   - Click the heart icon to add the city to your list of favorite cities.

3. **View Favorites:**

   - Press the "Your Favorite Cities" button to navigate to the favorites page and view the saved cities.

4. **Select Favorite City:**
   - Click on a favorite city to view its current weather.

## File Structure

```
lib/
│
├── main.dart           # The main file where the app starts
├── favorites_page.dart # The page that shows the list of favorite cities
├── assets/
│   ├── icons/          # Icons for different weather conditions
│   └── gifs/           # GIFs for dynamic background based on weather
├── pubspec.yaml        # Pubspec file for managing dependencies and assets

```

## Assets

- **Icons:** The app includes various weather icons such as clear, clouds, rain, snow, etc., which are located in the assets/icons/ directory.

- **Backgrounds:** GIFs for dynamic backgrounds based on weather conditions are stored in the assets/gifs/ directory.

## Design

1. **User Interface (UI) Design**

   - **Minimalistic and Intuitive Design:** The app uses a simple, clean layout to ensure users can easily search for weather information without distraction. The focus is on ease of use, with a prominent search bar and essential weather data displayed clearly.

   - **Dynamic Visuals:** Weather-specific icons and background GIFs were chosen to make the app visually engaging and to provide users with a quick, intuitive understanding of the current weather conditions.

2. **Color and Theme Choices**

   - **Color-coded Temperature Display:** Colors are used to represent temperature ranges, offering a quick visual cue about how hot or cold it is. Cooler temperatures are represented with blue tones, while warmer temperatures use orange and red.

3. **State Management**

   - **Simple State Management:** The app uses setState to manage UI updates, given its relatively small scale. This approach is straightforward and keeps the app's logic easy to understand.

   - **Error Handling and Loading States:** Designated states for loading (\_isLoading) and errors (\_hasError) help in providing users with appropriate feedback during data fetching.

4. **API Integration**

   - **OpenWeatherMap API:** Chosen for its comprehensive and reliable weather data, the OpenWeatherMap API is integrated with minimal complexity, offering a straightforward way to fetch weather data based on city names.

   - **Error Messaging:** Clear error messages are displayed if the API fails to return data, ensuring users are informed of issues rather than being left in the dark.

5. **Responsive Layout:**

   - **Adaptable Design:** The UI components, such as the search bar and weather display, are designed to be responsive, ensuring the app looks good on different screen sizes and orientations.
