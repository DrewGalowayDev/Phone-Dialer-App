@echo off
REM Setup script for Phone Dialer App
REM This script automates the Flutter project setup

REM Set Flutter path to the newly installed version
set "FLUTTER_PATH=C:\Program Files\flutter_windows_3.38.3-stable\flutter\bin"
set "PATH=%FLUTTER_PATH%;%PATH%"

echo ================================================
echo Phone Dialer App - Setup Script
echo ================================================
echo.

REM Check if Flutter is installed
echo [1/6] Checking Flutter installation...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter from https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)
echo Flutter is installed!
echo.

REM Navigate to the correct directory
echo [2/6] Navigating to project directory...
cd /d "c:\Users\user\OneDrive\Desktop\flutter dial app"
if %errorlevel% neq 0 (
    echo ERROR: Could not navigate to project directory
    pause
    exit /b 1
)
echo Current directory: %CD%
echo.

REM Create Flutter project structure
echo [3/6] Creating Flutter project structure...
echo This will take a moment...
flutter create phone_dialer_app
if %errorlevel% neq 0 (
    echo ERROR: Failed to create Flutter project
    pause
    exit /b 1
)
echo Flutter project created successfully!
echo.

REM Navigate to project directory
echo [4/6] Navigating to project folder...
cd phone_dialer_app
echo Current directory: %CD%
echo.

REM Add dependencies
echo [5/6] Adding required dependencies...
echo Adding url_launcher...
call flutter pub add url_launcher
echo Adding permission_handler...
call flutter pub add permission_handler
echo Adding flutter_phone_direct_caller...
call flutter pub add flutter_phone_direct_caller
echo.

REM Get all dependencies
echo [6/6] Getting all dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)
echo.

echo ================================================
echo Setup Complete!
echo ================================================
echo.
echo Your Flutter Phone Dialer App is ready!
echo.
echo NEXT STEPS:
echo 1. Connect your Android or iOS device
echo 2. Enable USB debugging (Android) or trust computer (iOS)
echo 3. Run: flutter run
echo.
echo Or you can build the app:
echo - Android APK: flutter build apk
echo - iOS IPA: flutter build ios
echo.
echo NOTE: The app requires a physical device with cellular
echo       capability to make actual phone calls.
echo.
pause
