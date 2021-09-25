import 'package:flutter/material.dart';
import 'theme.dart';
import './widgets/add_event.dart';

void main() => runApp(AttendenceApp());

class AttendenceApp extends StatelessWidget {
  const AttendenceApp({Key? key}) : super(key: key);

  static final baseUrl = 'http://localhost:8080/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      routes: {
        "/addEvent": (context) => AddEvent(),
        "/": (context) => AddEvent()
      },
    );
  }
}
