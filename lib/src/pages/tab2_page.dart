import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/services/new_services.dart';
import 'package:noticias/src/utls/utls.dart';
import 'package:provider/provider.dart';
import 'package:noticias/src//theme/mytheme.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(child: ListaNoticias(noticias: newsService.getArticulosByCategory,),)
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _CategoryButton(category: categories[index]),
                  SizedBox(height: 5.0,),
                  Text(CapitalizeWord(categories[index].name)),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    @required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (){
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = category.name;
        },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)? myTheme.accentColor : Colors.black54,
        ),
      ),
    );
  }
}
