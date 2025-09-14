# GPA Calculator

## Overview
GPA Calculator is a cross-platform Flutter application that helps students calculate their Grade Point Average (GPA) based on their courses, credit units, and grades. The app provides a simple interface to enter course details, view them in a table, calculate the GPA, and reset the data as needed.

## Features
- Add courses with course name, credit unit, and grade
- View all entered courses in a table
- Select grades from a dropdown menu
- Calculate GPA with a single button click
- Reset all data and clear the table
- Responsive UI for mobile and desktop
- State management using Flutter BLoC

## How It Works
1. **Enter Course Details:**
   - Type the course name in the input field.
   - Enter the credit unit for the course.
   - Select the grade from the dropdown menu.
2. **Add Course:**
   - Click the "Add" button to add the course to the table below.
   - The input fields will clear after adding.
3. **View Table:**
   - All added courses are displayed in a table with their details.
4. **Calculate GPA:**
   - Click the "Calculate" button to compute your GPA based on the entered courses.
   - The GPA will be displayed below the table.
5. **Reset Data:**
   - Click the "Reset" button to clear all entered courses and reset the input fields.

## Tools & Technologies Used
- **Flutter**: UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: Programming language for Flutter development.
- **Flutter BLoC**: State management library for predictable and scalable app architecture.
- **Material Design**: For modern and responsive UI components.

## Getting Started
1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

## Folder Structure
- `lib/`
  - `main.dart`: App entry point
  - `pages/gpa_page.dart`: Main UI page
  - `bloc/`: Contains BLoC files for state management
    - `gpa_bloc.dart`: BLoC logic
    - `gpa_event.dart`: BLoC events
    - `gpa_state.dart`: BLoC state

## Screenshots
![alt text](Screenshot_20250914-163411.jpg)


## License
This project is licensed under the MIT License.
# gpa_calculator
