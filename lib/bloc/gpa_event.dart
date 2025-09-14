// This file defines the events for the GPA calculator BLoC.
// Events are used to tell the BLoC that something happened in the UI.

// The base class for all GPA events.
abstract class GpaEvent {}

// This event is triggered when the user selects a new value from the dropdown menu.
// It carries the selected value so the BLoC can update the state.
class ValueForDropDownMenu extends GpaEvent {
  final String selectedValue;
  ValueForDropDownMenu(this.selectedValue);
}

// This event is triggered when the user adds a new course entry.
class AddCourseEvent extends GpaEvent {
  final String courseName;
  final int creditUnit;
  final String grade;
  AddCourseEvent({required this.courseName, required this.creditUnit, required this.grade});
}

// This event is triggered when the user wants to calculate their GPA.
class CalculateGpaEvent extends GpaEvent {}

// This event is triggered when the user wants to reset all data.
class ResetEvent extends GpaEvent {}

// Event to update the course input value
class UpdateCourseInputEvent extends GpaEvent {
  final String courseInput;
  UpdateCourseInputEvent(this.courseInput);
}

// Event to update the credit input value
class UpdateCreditInputEvent extends GpaEvent {
  final String creditInput;
  UpdateCreditInputEvent(this.creditInput);
}