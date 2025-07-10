# Urban Wildlife Tracker 🦌🏙️

A modern Flutter mobile application for tracking wildlife sightings in urban areas. Built with Firebase backend for real-time data synchronization and user authentication.

## 🚀 Features

- **User Authentication**: Secure login and registration with Firebase Auth
- **Interactive Map**: Real-time map displaying wildlife sightings using OpenStreetMap
- **Location Services**: Automatic GPS location detection for sighting submissions
- **Photo Capture**: Camera integration for documenting wildlife
- **Cloud Storage**: Firebase Storage for image uploads
- **Real-time Database**: Cloud Firestore for sighting data
- **Cross-platform**: Works on Android, iOS, and Web

## 📱 Screenshots

The app includes:
- Login/Registration screens
- Interactive map with wildlife markers
- Sighting submission form with photo capture
- Location-based services

## 🛠️ Technical Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Authentication
  - Cloud Firestore (Database)
  - Cloud Storage (Images)
- **Maps**: Flutter Map with OpenStreetMap tiles
- **Location**: Geolocator plugin
- **Camera**: Image Picker plugin

## 📦 Installation

### Prerequisites
- Flutter SDK (3.0+)
- Android Studio / VS Code
- Android SDK (API 23+)
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/urban_wildlife_tracker.git
   cd urban_wildlife_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   **Web version:**
   ```bash
   flutter run -d chrome
   ```
   
   **Android version:**
   ```bash
   flutter run
   ```
   
   **Simple demo version (no Firebase):**
   ```bash
   flutter run -t lib/main_simple.dart
   ```

4. **Build for production**
   
   **Android APK:**
   ```bash
   flutter build apk --release
   ```
   
   **Web:**
   ```bash
   flutter build web
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # Main app entry point (Firebase version)
├── main_simple.dart         # Simple version without Firebase
├── firebase_options.dart    # Firebase configuration
└── screens/
    ├── auth/
    │   ├── login_screen.dart    # User login
    │   └── register_screen.dart # User registration
    ├── home_screen.dart         # Main map view
    └── submit_screen.dart       # Sighting submission form
```

## 🔧 Configuration

### Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Email/Password)
3. Create Cloud Firestore database
4. Enable Cloud Storage
5. Add your Android/iOS/Web app to the project
6. Update `firebase_options.dart` with your configuration

### Android Permissions
The app requires these permissions (already configured in AndroidManifest.xml):
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `CAMERA`
- `INTERNET`
- `WRITE_EXTERNAL_STORAGE`

## 🚀 Usage

### For Users
1. **Register/Login**: Create an account or sign in
2. **View Map**: Browse existing wildlife sightings on the interactive map
3. **Submit Sighting**: 
   - Tap the + button
   - Enter animal type and notes
   - Take a photo (optional)
   - Location is automatically detected
   - Submit to share with the community
4. **Explore**: Tap on map markers to view sighting details

### For Developers
- Use `main_simple.dart` for development without Firebase setup
- Full Firebase version is in `main.dart`
- All Firebase services are properly configured
- Error handling and loading states included

## 🧪 Testing

**Run tests:**
```bash
flutter test
```

**Check for issues:**
```bash
flutter analyze
```

**Format code:**
```bash
flutter format .
```

## 📱 Build Information

- **Minimum Android SDK**: 23 (Android 6.0)
- **Target Android SDK**: Latest
- **iOS Deployment Target**: iOS 12.0+
- **Web**: Modern browsers with JavaScript support

## 🎯 Future Enhancements

- Species identification with AI
- Offline mode support
- Push notifications for nearby sightings
- Social features (comments, likes)
- Data analytics and insights
- Integration with wildlife conservation APIs

## 🐛 Troubleshooting

**Common Issues:**

1. **Location not working**: Ensure location permissions are granted
2. **Camera not working**: Check camera permissions
3. **Firebase errors**: Verify firebase_options.dart configuration
4. **Build errors**: Run `flutter clean && flutter pub get`

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## 📞 Support

For issues and questions:
- Open a GitHub issue
- Check the Flutter documentation
- Review Firebase documentation

---

**Built with ❤️ using Flutter and Firebase**
