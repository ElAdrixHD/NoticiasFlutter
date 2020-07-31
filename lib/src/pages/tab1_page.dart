import 'package:flutter/material.dart';
import 'package:noticias/src/services/new_services.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  static final route = "/Tab1Page";

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final _newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (_newsService.headlines.length == 0)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(onRefresh: () { return _newsService.getTopHeadlines(); },
          child: ListaNoticias(noticias: _newsService.headlines,))

    );
  }

  @override
  bool get wantKeepAlive => true;
}
