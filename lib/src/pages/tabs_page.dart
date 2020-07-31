import 'package:flutter/material.dart';
import 'package:noticias/src/pages/tab1_page.dart';
import 'package:noticias/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  static final route = "/tabpages";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _NavegacionModel(),
      child: Scaffold(
        body: _BuildPageView(),
        bottomNavigationBar: _BuildBottomNavigationBar(),
      ),
    );
  }
}

class _BuildPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _navModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _navModel._pageController,
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _BuildBottomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _navModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: _navModel.paginaActual,
      onTap: (int index) => _navModel.paginaActual = index,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text("Para ti")),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text("Encabezados")),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{
  int _pagActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => _pagActual;
  PageController get pageController => _pageController;

  set paginaActual (int value){
    _pagActual = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
    notifyListeners();
  }
}

//5fc84f5e9b124567a35b3130dec6fae6
