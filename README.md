# Phone Dialer App

A modern Flutter mobile application for making phone calls with a beautiful gradient UI, proper permission handling, and production-ready code quality.

## Features

✅ **Phone Number Input** - TextFormField with validation and formatting  
✅ **Call Functionality** - Initiate calls using url_launcher with tel: scheme  
✅ **Permission Handling** - Runtime permission requests for Android and iOS  
✅ **Modern UI** - Gradient blue/purple theme with Material Design 3  
✅ **Animated Buttons** - Custom dial button widget with press effects  
✅ **Error Handling** - User-friendly error messages with SnackBars  
✅ **Call State Indicators** - Visual feedback for call status  
✅ **Responsive Design** - Works on different screen sizes  

## Screenshots
![alt text](image.png)
![alt text](image-1.png)


## Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for Android/iOS development)
- A physical device with cellular capability (emulators cannot make real calls)

Check your Flutter installation:
```bash
flutter doctor
```

## Setup Instructions

### 1. Navigate to the Project Directory

```bash
cd "c:\Users\user\OneDrive\Desktop\flutter dial app"
```

### 2. Create Flutter Project Structure

The code files have been generated, but you need to initialize the Flutter project:

```bash
flutter create phone_dialer_app
```

This will create the necessary Flutter project structure including platform-specific files.

### 3. Navigate to Project

```bash
cd phone_dialer_app
```

### 4. Add Dependencies

Add all required packages:

```bash
flutter pub add url_launcher
flutter pub add permission_handler
flutter pub add flutter_phone_direct_caller
```

### 5. Get Dependencies

```bash
flutter pub get
```

### 6. Verify Setup

Check that all files are in place:
- `lib/main.dart` - Main entry point
- `lib/screens/phone_dialer_screen.dart` - Main UI screen
- `lib/widgets/dial_button.dart` - Custom button widget
- `lib/utils/phone_utils.dart` - Phone validation utilities
- `pubspec.yaml` - Dependencies
- `android/app/src/main/AndroidManifest.xml` - Android permissions
- `ios/Runner/Info.plist` - iOS permissions

## Running the App

### On Android Device

1. Connect your Android device via USB
2. Enable USB debugging on your device
3. Run:
```bash
flutter run
```

### On iOS Device

1. Connect your iOS device
2. Open Xcode and configure code signing
3. Run:
```bash
flutter run
```

### Build APK (Android)

To build a release APK:
```bash
flutter build apk --release
```

The APK will be in `build/app/outputs/flutter-apk/app-release.apk`

### Build IPA (iOS)

To build a release IPA:
```bash
flutter build ios --release
```

## Project Structure

```
phone_dialer_app/
├── lib/
│   ├── main.dart                      # App entry point with theming
│   ├── screens/
│   │   └── phone_dialer_screen.dart   # Main dialer UI
│   ├── widgets/
│   │   └── dial_button.dart           # Custom animated button
│   └── utils/
│       └── phone_utils.dart           # Phone validation utilities
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml        # Android permissions
├── ios/
│   └── Runner/
│       └── Info.plist                 # iOS permissions
├── pubspec.yaml                       # Dependencies
└── README.md                          # This file
```

## Permissions

### Android
The following permissions are declared in `AndroidManifest.xml`:
- `CALL_PHONE` - Required to initiate phone calls
- `READ_PHONE_STATE` - Required to check phone state
- `INTERNET` - Required for network operations

### iOS
The following permission is declared in `Info.plist`:
- `NSContactsUsageDescription` - Required for phone call access

## Usage

1. **Launch the app** on your device
2. **Enter a phone number** in the input field (minimum 10 digits)
3. **Tap the Dial button** to initiate the call
4. **Grant permission** when prompted
5. **Make the call** - Your device's phone app will open
6. **Use device controls** to end the call

## Dependencies

- **url_launcher** (^6.2.2) - For initiating phone calls
- **permission_handler** (^11.1.0) - For runtime permission handling
- **flutter_phone_direct_caller** (^2.1.1) - Alternative calling method
- **cupertino_icons** (^1.0.6) - iOS-style icons

## Code Features

### Phone Validation
- Minimum 10 digits required
- Real-time validation feedback
- Supports international numbers with country codes

### UI/UX
- Gradient background (dark blue to navy)
- Card-based input section with elevation
- Animated button press effects
- Loading indicators during permission requests
- Status indicators for call state
- SnackBar notifications for success/error

### Error Handling
- Permission denied scenarios
- Invalid phone numbers
- Device cannot make calls
- Network errors

## Troubleshooting

### Permission Issues
If permissions are denied:
- Go to device Settings > Apps > Phone Dialer App > Permissions
- Grant Phone permission manually

### Build Issues
If you encounter build issues:
```bash
flutter clean
flutter pub get
flutter run
```

### Android SDK Issues
Ensure you have the required Android SDK:
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 33 or higher

## Testing

Since this app requires actual phone hardware, testing should be done on physical devices:

1. Test with valid phone numbers (10+ digits)
2. Test with invalid inputs (< 10 digits, letters, etc.)
3. Test permission flows (grant, deny, permanently deny)
4. Test on different screen sizes
5. Test actual call functionality

## Notes

⚠️ **Important**: 
- This app requires a physical device with cellular capability
- Emulators cannot make real phone calls
- Ensure you have an active SIM card with calling capability
- Test with real phone numbers responsibly

## Future Enhancements

Potential features for future versions:
- Call history logging
- Contact integration
- Speed dial favorites
- Call duration tracking
- Recent calls list
- Dark/light theme toggle

## License

This project is provided as-is for educational and development purposes.

## Support

For issues or questions:
1. Check Flutter documentation: https://flutter.dev/docs
2. Check package documentation:
   - url_launcher: https://pub.dev/packages/url_launcher
   - permission_handler: https://pub.dev/packages/permission_handler

---

**Built with Flutter 💙**
