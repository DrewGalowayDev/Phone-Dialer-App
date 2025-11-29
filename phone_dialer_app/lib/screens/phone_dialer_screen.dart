import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/dial_button.dart';
import '../utils/phone_utils.dart';

/// Main screen for the phone dialer application
/// Handles phone number input, validation, and call initiation
class PhoneDialerScreen extends StatefulWidget {
  const PhoneDialerScreen({Key? key}) : super(key: key);

  @override
  State<PhoneDialerScreen> createState() => _PhoneDialerScreenState();
}

class _PhoneDialerScreenState extends State<PhoneDialerScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCallInProgress = false;
  bool _isRequestingPermission = false;
  String _callStatus = 'Ready to dial';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Requests phone call permission from the user
  Future<bool> _requestPhonePermission() async {
    setState(() {
      _isRequestingPermission = true;
      _callStatus = 'Requesting permission...';
    });

    try {
      final status = await Permission.phone.request();
      
      setState(() {
        _isRequestingPermission = false;
      });

      if (status.isGranted) {
        setState(() => _callStatus = 'Permission granted');
        return true;
      } else if (status.isDenied) {
        _showErrorSnackBar('Phone call permission denied');
        setState(() => _callStatus = 'Permission denied');
        return false;
      } else if (status.isPermanentlyDenied) {
        _showErrorSnackBar(
          'Permission permanently denied. Please enable it in app settings.',
        );
        setState(() => _callStatus = 'Permission permanently denied');
        // Open app settings
        await openAppSettings();
        return false;
      }
    } catch (e) {
      setState(() {
        _isRequestingPermission = false;
        _callStatus = 'Permission error';
      });
      _showErrorSnackBar('Error requesting permission: $e');
      return false;
    }

    return false;
  }

  /// Initiates a phone call to the entered number
  Future<void> _makePhoneCall() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Clean the phone number
    String phoneNumber = PhoneUtils.cleanPhoneNumber(_phoneController.text);

    setState(() {
      _callStatus = 'Checking permissions...';
    });

    // Check if permission is already granted
    final permissionStatus = await Permission.phone.status;
    
    bool hasPermission = false;
    if (permissionStatus.isGranted) {
      hasPermission = true;
    } else {
      hasPermission = await _requestPhonePermission();
    }

    if (!hasPermission) {
      return;
    }

    setState(() {
      _callStatus = 'Initiating call...';
    });

    try {
      // Make direct call using flutter_phone_direct_caller
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      
      setState(() {
        _isCallInProgress = true;
        _callStatus = 'Call in progress';
      });
      
      _showSuccessSnackBar('Calling $phoneNumber');
    } catch (e) {
      setState(() {
        _callStatus = 'Call failed';
      });
      _showErrorSnackBar('Failed to initiate call: $e');
    }
  }

  /// Ends the current call
  /// Note: There's no direct way to programmatically end a call in Flutter
  /// This method updates the UI state
  void _endCall() {
    setState(() {
      _isCallInProgress = false;
      _callStatus = 'Call ended';
    });
    
    _showSuccessSnackBar('Call ended');
    
    // Reset status after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _callStatus = 'Ready to dial';
        });
      }
    });
  }

  /// Shows a success message to the user
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Shows an error message to the user
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A1A2E), // Dark blue-purple
              Color(0xFF16213E), // Deep blue
              Color(0xFF0F3460), // Navy blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title
                const Text(
                  'Phone Dialer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Status Indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isCallInProgress
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isCallInProgress
                          ? Colors.green
                          : Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _isCallInProgress ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _callStatus,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Phone Input Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter Phone Number',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Phone Number Input Field
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                            decoration: InputDecoration(
                              hintText: '+1 (555) 123-4567',
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Color(0xFF6B4CE6),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6B4CE6),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: PhoneUtils.validatePhoneNumber,
                            inputFormatters: [
                              // Limit to 20 characters for international numbers
                              LengthLimitingTextInputFormatter(20),
                            ],
                            onChanged: (value) {
                              // Trigger validation on change
                              if (_formKey.currentState != null) {
                                _formKey.currentState!.validate();
                              }
                            },
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Helper text
                          Text(
                            'Enter at least 10 digits',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Action Buttons
                if (_isCallInProgress) ...[
                  // End Call Button
                  DialButton(
                    label: 'End Call',
                    icon: Icons.call_end,
                    onPressed: _endCall,
                    startColor: Colors.red.shade600,
                    endColor: Colors.red.shade800,
                  ),
                ] else ...[
                  // Dial Button
                  DialButton(
                    label: 'Dial',
                    icon: Icons.call,
                    onPressed: _makePhoneCall,
                    isEnabled: !_isRequestingPermission,
                    isLoading: _isRequestingPermission,
                  ),
                ],

                const SizedBox(height: 16),

                // Info Text
                Center(
                  child: Text(
                    _isCallInProgress
                        ? 'Use your device to end the call'
                        : 'Tap to make a call',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
