# 🌦️ Weather Forecast Application

## Overview

This is a simple Flutter-based Weather App that fetches current weather data for a given city using the OpenWeatherMap API. The app features a clean and intuitive UI, allowing users to search for weather information, view the current weather conditions, and save their favorite cities for easy access.

The app is hosted on Netlify and can be accessed via the following URL:

**[Access the Weather App on Netlify](https://weatherforecastappnar.netlify.app)**

**Note:** The app is optimized for phone devices and is best experienced on mobile rather than desktop.

## 🚀 Features

🔍 **Weather Search:**
Search for current weather conditions by entering any city name.

❤️ **Favorites Management:**
Save and manage your favorite cities for easy access to their weather data.
🌈 **Dynamic UI:**
The app's background and icons change based on the current weather, providing a visually engaging experience.

📱 **Responsive Design:**
The layout adapts to different screen sizes for a seamless experience across devices.

## 🛠️ Installation

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

## 🔑 API KEY

This app uses the OpenWeatherMap API to fetch weather data. Replace the API key in the code with your own to avoid reaching the API request limit.

```dart
final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric';

```

You can obtain an API key by signing up at OpenWeatherMap.

## 📂 File Structure

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

## 🖼️ Assets

- **Icons:** The app includes various weather icons such as clear, clouds, rain, snow, etc., which are located in the assets/icons/ directory.

- **Backgrounds:** GIFs for dynamic backgrounds based on weather conditions are stored in the assets/gifs/ directory.

## 🎨 Design

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
