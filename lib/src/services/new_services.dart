import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/models/news_models.dart';

import '../models/news_models.dart';
import '../models/news_models.dart';

const _URLNEWS = "https://newsapi.org/v2";
const _APIKEY = "5fc84f5e9b124567a35b3130dec6fae6";

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = "business";

  List<Category> categories = [
    Category(FontAwesomeIcons.businessTime, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.heart, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.footballBall, "sports"),
    Category(FontAwesomeIcons.mobile, "technology"),
  ];

  Map<String,List<Article>> categoryArticles = {};

  NewsService(){
    getTopHeadlines();
    categories.forEach((element) {
      categoryArticles[element.name] = List();
    });
    getArticleByCategory(_selectedCategory);
  }

  get selectedCategory => _selectedCategory;
  set selectedCategory (String valor){
    _selectedCategory = valor;
    getArticleByCategory(valor);
    notifyListeners();
  }

  List<Article>get getArticulosByCategory => categoryArticles[_selectedCategory];

  Future<void> getTopHeadlines() async{
    final _url = "$_URLNEWS/top-headlines?apiKey=$_APIKEY&country=gb";
    final res = await get(_url);

    final newsResponse = newsResponseFromJson(res.body);
    this.headlines.clear();
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  Future<void> getArticleByCategory(String category) async{
    final _url = "$_URLNEWS/top-headlines?apiKey=$_APIKEY&category=$category&country=gb";
    final res = await get(_url);

    final newsResponse = newsResponseFromJson(res.body);
    this.categoryArticles[category].clear();
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}