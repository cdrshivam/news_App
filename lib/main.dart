import 'package:flutter/material.dart';

import './screens/home.dart';

void main()
{
  runApp(
    MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
    ),
  );
}