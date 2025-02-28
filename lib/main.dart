import 'package:cine_creators/router/router_config.dart';
import 'package:flutter/material.dart';
import "package:supabase_flutter/supabase_flutter.dart";

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xaiqycoyfofnvgagamcm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhaXF5Y295Zm9mbnZnYWdhbWNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0Mzk2MjksImV4cCI6MjA1NTAxNTYyOX0.jj7_zY7sUkdl7p-FSHmp21Bvc94slBh-Y44i7VC2MjQ',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData.dark(),
    );
  }
}
