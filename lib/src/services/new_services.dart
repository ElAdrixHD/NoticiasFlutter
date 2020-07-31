import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/models/news_models.dart';

const _URLNEWS = "https://newsapi.org/v2";
const _APIKEY = "5fc84f5e9b124567a35b3130dec6fae6";

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.businessTime, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.heart, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.footballBall, "sports"),
    Category(FontAwesomeIcons.mobile, "technology"),
  ];

  NewsService(){
    getTopHeadlines();
  }

  Future<void> getTopHeadlines() async{
    final _url = "$_URLNEWS/top-headlines?apiKey=$_APIKEY&country=gb";
    final res = await get(_url);

    final newsResponse = newsResponseFromJson(res.body);
    this.headlines.clear();
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}