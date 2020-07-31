import 'package:flutter/material.dart';
import 'package:noticias/src/pages/tabs_page.dart';
import 'package:noticias/src/services/new_services.dart';
import 'package:noticias/src/theme/mytheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService(),)
      ],
      child: MaterialApp(
        title: "Noticias",
        debugShowCheckedModeBanner: false,
        initialRoute: TabsPage.route,
        theme: myTheme,
        routes: {
          TabsPage.route : (BuildContext context) => TabsPage(),
        },
      ),
    );
  }
}