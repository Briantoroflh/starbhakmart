import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/splashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ktrnxlysmukrssjydcyu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0cm54bHlzbXVrcnNzanlkY3l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMzM0NTMsImV4cCI6MjA0NzkwOTQ1M30.QtGBEWD2Y86TTGeEJb4g9zQOF9vhm3FLAcyuxD4SkmQ',
  );

  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StarMart',
      debugShowCheckedModeBanner: false,
      home:  Splashscreen(),
    );
  }
}


