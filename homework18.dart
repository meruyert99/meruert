import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        isDark: isDark,
        onThemeChanged: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Adaptive UI'),
        actions: [
          Switch(
            value: isDark,
            onChanged: (_) => onThemeChanged(),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(isWide ? 32 : 16),
        child: isWide
            ? Row(
                children: [
                  Expanded(child: infoCard(context, 'Левая панель')),
                  const SizedBox(width: 24),
                  Expanded(child: infoCard(context, 'Правая панель')),
                ],
              )
            : Column(
                children: [
                  infoCard(context, 'Верхний блок'),
                  const SizedBox(height: 16),
                  infoCard(context, 'Нижний блок'),
                ],
              ),
      ),
    );
  }

  Widget infoCard(BuildContext context, String title) {
    final width = MediaQuery.of(context).size.width;
    final double fontSize = width > 600 ? 22 : 16;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
