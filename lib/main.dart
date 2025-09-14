import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa_calculator/bloc/gpa_bloc.dart';
import 'package:gpa_calculator/pages/gpa_page.dart';

void main() {
  // The entry point of the Flutter application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA CALCULATOR', // Sets the title of the app.
      debugShowCheckedModeBanner: false, // Removes the debug banner.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Sets the app theme color.
      ),
      // MultiBlocProvider allows you to provide multiple BLoCs to the widget tree.
      // Here, we provide the GpaBloc so it can be accessed anywhere in the app.
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => GpaBloc())],
        child: GpaPage(), // The main page of the app.
      ),
    );
  }
}
