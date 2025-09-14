// This file defines the BLoC (Business Logic Component) for the GPA calculator.
// The BLoC handles events and updates the state accordingly.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa_calculator/bloc/gpa_event.dart';
import 'package:gpa_calculator/bloc/gpa_state.dart';

// The GpaBloc class manages the state of the GPA calculator.
// It listens for events and emits new states when something changes.
class GpaBloc extends Bloc<GpaEvent, GpaState> {
  GpaBloc() : super(GpaState(selectedValue: "A")) {
    // Handle dropdown value change
    on<ValueForDropDownMenu>((event, emit) {
      emit(GpaState(
        selectedValue: event.selectedValue,
        courses: state.courses,
        gpa: state.gpa,
        courseInput: state.courseInput,
        creditInput: state.creditInput,
      ));
    });

    // Handle updating course input
    on<UpdateCourseInputEvent>((event, emit) {
      emit(GpaState(
        selectedValue: state.selectedValue,
        courses: state.courses,
        gpa: state.gpa,
        courseInput: event.courseInput,
        creditInput: state.creditInput,
      ));
    });

    // Handle updating credit input
    on<UpdateCreditInputEvent>((event, emit) {
      emit(GpaState(
        selectedValue: state.selectedValue,
        courses: state.courses,
        gpa: state.gpa,
        courseInput: state.courseInput,
        creditInput: event.creditInput,
      ));
    });

    // Handle adding a new course entry
    on<AddCourseEvent>((event, emit) {
      final newCourse = CourseEntry(
        courseName: event.courseName,
        creditUnit: event.creditUnit,
        grade: event.grade,
      );
      emit(GpaState(
        selectedValue: state.selectedValue,
        courses: List.from(state.courses)..add(newCourse),
        gpa: state.gpa,
        courseInput: '', // Clear input after add
        creditInput: '', // Clear input after add
      ));
    });

    // Handle GPA calculation
    on<CalculateGpaEvent>((event, emit) {
      double totalPoints = 0;
      int totalCredits = 0;
      for (var course in state.courses) {
        final gradeValue = state.grades[course.grade] ?? 0;
        totalPoints += gradeValue * course.creditUnit;
        totalCredits += course.creditUnit;
      }
      double calculatedGpa = totalCredits > 0 ? totalPoints / totalCredits : 0;
      emit(GpaState(
        selectedValue: state.selectedValue,
        courses: state.courses,
        gpa: calculatedGpa,
        courseInput: state.courseInput,
        creditInput: state.creditInput,
      ));
    });

    // Handle reset
    on<ResetEvent>((event, emit) {
      emit(GpaState(
        selectedValue: "A",
        courses: [],
        gpa: null,
        courseInput: '',
        creditInput: '',
      ));
    });
  }
}