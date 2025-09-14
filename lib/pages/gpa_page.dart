import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa_calculator/bloc/gpa_bloc.dart';
import 'package:gpa_calculator/bloc/gpa_event.dart';
import 'package:gpa_calculator/bloc/gpa_state.dart';

// This widget is fully stateless and uses BLoC for all state management, including input fields.
class GpaPage extends StatelessWidget {
  const GpaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GpaBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("GPA CALCULATOR", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<GpaBloc, GpaState>(
            builder: (context, state) {
              // Controllers are recreated each build, but their text is set from BLoC state
              final courseController = TextEditingController(
                text: state.courseInput,
              );
              final creditController = TextEditingController(
                text: state.creditInput,
              );
              // Listen for changes and dispatch events to BLoC
              courseController.selection = TextSelection.fromPosition(
                TextPosition(offset: courseController.text.length),
              );
              creditController.selection = TextSelection.fromPosition(
                TextPosition(offset: creditController.text.length),
              );
              return Column(
                children: [
                  // Course input field
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Enter Course:",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: courseController,
                      onChanged: (value) {
                        context.read<GpaBloc>().add(
                          UpdateCourseInputEvent(value),
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Credit unit input field
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Enter Credit Unit:",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: creditController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<GpaBloc>().add(
                          UpdateCreditInputEvent(value),
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Grade dropdown
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Enter Grade:",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: DropdownButtonFormField<String>(
                      value: state.selectedValue.isEmpty
                          ? null
                          : state.selectedValue, // Show no selection if empty
                      items: state.grades.keys.map((grade) {
                        return DropdownMenuItem(
                          value: grade,
                          child: Text(grade),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<GpaBloc>().add(
                            ValueForDropDownMenu(value),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      ),
                      hint: Text(
                        'Select Grade',
                      ), // Show hint when no grade is selected
                    ),
                  ),
                  SizedBox(height: 10),
                  // Add button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.grey),
                      ),
                      onPressed: () {
                        final course = state.courseInput.trim();
                        final credit =
                            int.tryParse(state.creditInput.trim()) ?? 0;
                        final grade = state.selectedValue;
                        if (course.isNotEmpty &&
                            credit > 0 &&
                            grade.isNotEmpty) {
                          context.read<GpaBloc>().add(
                            AddCourseEvent(
                              courseName: course,
                              creditUnit: credit,
                              grade: grade,
                            ),
                          );
                        }
                      },
                      child: Text("Add", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Table of entered courses
                  Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Course')),
                          DataColumn(label: Text('Credit')),
                          DataColumn(label: Text('Grade')),
                        ],
                        rows: state.courses
                            .map(
                              (course) => DataRow(
                                cells: [
                                  DataCell(Text(course.courseName)),
                                  DataCell(Text(course.creditUnit.toString())),
                                  DataCell(Text(course.grade)),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  // GPA display
                  if (state.gpa != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "GPA: ${state.gpa!.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  // Calculate and Reset buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.green,
                            ),
                          ),
                          onPressed: () {
                            context.read<GpaBloc>().add(CalculateGpaEvent());
                          },
                          child: Text(
                            "Calculate",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            context.read<GpaBloc>().add(ResetEvent());
                          },
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
