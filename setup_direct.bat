@echo off
REM Setup script using full Flutter path
REM This bypasses PATH issues

SET FLUTTER_PATH="C:\Program Files\flutter\flutter_windows_3.35.3-stable\flutter\bin\flutter.bat"

echo ================================================
echo Phone Dialer App - Setup (Direct Path)
echo ================================================
echo.

echo Using Flutter from: %FLUTTER_PATH%
echo.

REM Navigate to the correct directory
echo [1/6] Navigating to project directory...
cd /d "c:\Users\user\OneDrive\Desktop\flutter dial app"
echo Current directory: %CD%
echo.

REM Create Flutter project structure
echo [2/6] Creating Flutter project structure...
echo This will take a moment...
%FLUTTER_PATH% create phone_dialer_app
if %errorlevel% neq 0 (
    echo ERROR: Failed to create Flutter project
    pause
    exit /b 1
)
echo Flutter project created successfully!
echo.

REM Navigate to project directory
echo [3/6] Navigating to project folder...
cd phone_dialer_app
echo Current directory: %CD%
echo.

REM Add dependencies
echo [4/6] Adding required dependencies...
echo Adding url_launcher...
%FLUTTER_PATH% pub add url_launcher
echo Adding permission_handler...
%FLUTTER_PATH% pub add permission_handler
echo Adding flutter_phone_direct_caller...
%FLUTTER_PATH% pub add flutter_phone_direct_caller
echo.

REM Get all dependencies
echo [5/6] Getting all dependencies...
%FLUTTER_PATH% pub get
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
echo 3. Run: %FLUTTER_PATH% run
echo.
echo Or you can build the app:
echo - Android APK: %FLUTTER_PATH% build apk
echo.
pause
