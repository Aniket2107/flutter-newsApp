import 'dart:convert';

import 'package:news/models/articleModel.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=add189aa9eb1417498aa71cbbd6c3b2e";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content']
          );
        news.add(articleModel); 
        }
      });
    } 
  }
}

class CategoryNewsClass{
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=add189aa9eb1417498aa71cbbd6c3b2e";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content']
          );
        news.add(articleModel); 
        }
      });
    } 
  }
}