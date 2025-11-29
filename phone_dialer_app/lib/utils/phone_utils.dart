/// Utility functions for phone number validation and formatting
class PhoneUtils {
  /// Validates if a phone number is valid
  /// Returns true if the phone number has at least 10 digits
  static bool isValidPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    // Check if it has at least 10 digits
    return digitsOnly.length >= 10;
  }

  /// Formats a phone number for display
  /// Example: "1234567890" -> "(123) 456-7890"
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.isEmpty) return '';
    
    // Format based on length
    if (digitsOnly.length <= 3) {
      return digitsOnly;
    } else if (digitsOnly.length <= 6) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
    } else if (digitsOnly.length <= 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else {
      // For numbers longer than 10 digits (international numbers)
      return '+${digitsOnly.substring(0, digitsOnly.length - 10)} (${digitsOnly.substring(digitsOnly.length - 10, digitsOnly.length - 7)}) ${digitsOnly.substring(digitsOnly.length - 7, digitsOnly.length - 4)}-${digitsOnly.substring(digitsOnly.length - 4)}';
    }
  }

  /// Cleans a phone number by removing all non-digit characters except +
  /// This is useful for preparing the number for the tel: URI
  static String cleanPhoneNumber(String phoneNumber) {
    // Keep only digits and + sign
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  /// Gets only the digits from a phone number
  static String getDigitsOnly(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }

  /// Validates and returns error message if invalid
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    
    String digitsOnly = getDigitsOnly(value);
    
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    return null; // Valid
  }
}
