# Quick Start Guide - Phone Dialer App

## 🚀 Fast Setup (3 Minutes)

### Step 1: Run Setup Script
```bash
cd "c:\Users\user\OneDrive\Desktop\flutter dial app"
setup.bat
```
**This will automatically:**
- Create Flutter project structure
- Install all dependencies
- Configure everything

### Step 2: Connect Device
- Connect your Android or iOS phone via USB
- Enable USB debugging (Android) or trust computer (iOS)

### Step 3: Run App
```bash
cd phone_dialer_app
flutter run
```

---

## 📋 Manual Setup Alternative

If you prefer manual control:

```bash
cd "c:\Users\user\OneDrive\Desktop\flutter dial app"
flutter create phone_dialer_app
cd phone_dialer_app
flutter pub add url_launcher permission_handler flutter_phone_direct_caller
flutter pub get
flutter run
```

---

## 🎯 What's Included

✅ Modern gradient UI (blue/purple theme)
✅ Phone number validation
✅ Permission handling
✅ Call functionality
✅ Animated buttons
✅ Error handling

---

## ⚠️ Important Notes

- **Must use physical device** (emulators can't make calls)
- **Requires SIM card** with calling capability
- **Test with real numbers** responsibly

---

## 🐛 Troubleshooting

**"Flutter not found"**
→ Install Flutter from https://flutter.dev

**"No devices found"**
→ Connect device and enable USB debugging

**"Permission denied"**
→ Go to Settings > Apps > Phone Dialer > Permissions

---

## 📁 Project Structure

```
phone_dialer_app/
├── lib/
│   ├── main.dart                 # App entry
│   ├── screens/
│   │   └── phone_dialer_screen.dart
│   ├── widgets/
│   │   └── dial_button.dart
│   └── utils/
│       └── phone_utils.dart
├── android/app/src/main/
│   └── AndroidManifest.xml      # Permissions
├── ios/Runner/
│   └── Info.plist               # iOS config
├── pubspec.yaml                 # Dependencies
└── README.md                    # Full docs
```

---

## 💡 Usage

1. Launch app
2. Enter phone number (min 10 digits)
3. Tap **Dial** button
4. Grant permission when asked
5. Call will initiate!

---

For detailed documentation, see [README.md](file:///c:/Users/user/OneDrive/Desktop/flutter%20dial%20app/phone_dialer_app/README.md)
