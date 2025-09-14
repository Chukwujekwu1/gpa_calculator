// Represents a single course entry for the GPA table.
class CourseEntry {
  final String courseName;
  final int creditUnit;
  final String grade;
  CourseEntry({required this.courseName, required this.creditUnit, required this.grade});
}

// This class represents the state for the GPA calculator BLoC.
// It holds the currently selected grade and the available grades.
class GpaState {
  // A map of grade letters to their corresponding values.
  final Map<String, double> grades = { "A": 5.0, "B": 4.0, "C": 3.0, "D": 2.0, "F": 1.0};

  // The currently selected grade value (e.g., "A", "B", etc.).
  final String selectedValue;

  // List of all entered courses
  final List<CourseEntry> courses;

  // Calculated GPA (nullable)
  final double? gpa;

  // Current value of course input field
  final String courseInput;

  // Current value of credit input field
  final String creditInput;

  // Constructor to initialize the selected grade value.
  GpaState({
    this.selectedValue = '',
    this.courses = const [],
    this.gpa,
    this.courseInput = '',
    this.creditInput = '',
  });
}
