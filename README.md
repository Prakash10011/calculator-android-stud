Calculator App 
Overview
This is a simple calculator app built using Flutter. It allows users to perform basic arithmetic operations like addition, subtraction, multiplication, and division. The app stores the last calculated value using SharedPreferences, so the result persists even after closing the app.

Features
Basic arithmetic operations: *+, -, , /
Persistent state using SharedPreferences
8-character limit for display to prevent overflow
Clean and user-friendly interface
Error handling for invalid operations (like division by zero)

How It Works
Number Input:

User presses a number → The display updates.
If it's a new entry or the display shows zero, the new number replaces it.
If there’s existing content, the number is appended.
Operation Input:

User selects an operator → First value and operation are stored.
Display resets for the next input.
Equals Calculation:

User presses "=" → Calculation is performed based on the selected operator.
Result is displayed and stored using SharedPreferences.
Invalid operations (like division by zero) show an "ERROR" message.
Clear Operations:

CE – Clears the current display.
C – Clears both display and stored values.

Project Structure
Key Files:

main.dart – Contains the entire logic and UI of the app.
pubspec.yaml – Manages project dependencies and settings.

State Management
setState() is used to update the display and app state.
SharedPreferences ensures that the last calculated value is retained between sessions.

Changes Made
Implemented state persistence with SharedPreferences.
Added input validation and error handling.
Streamlined UI for better user experience.

Why These Changes?
To create a smooth user experience with accurate calculations.
To maintain state consistency even after closing the app.
To provide simple and effective error handling.
