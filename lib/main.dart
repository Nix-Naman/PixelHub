import 'package:flutter/material.dart';
import 'package:pixelhub/model/wall_model.dart';
import 'package:pixelhub/screens/home_screen.dart';
import 'package:pixelhub/themes.dart';
import 'package:provider/provider.dart';
import 'themes.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WallpaperModel>(
      create: (context) => WallpaperModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes().light,
        darkTheme: Themes().dark,
        themeMode: ThemeMode.system,
        home: SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
