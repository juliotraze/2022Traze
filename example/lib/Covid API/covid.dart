import 'package:flutter/material.dart';
import 'Routes/routes.dart';
import 'Routes/routes_names.dart';


class Covid extends StatelessWidget {
  const Covid({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C19-Stats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesNames.splash_screen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
