import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/newsModel.dart';

String apiKey='5f4476ec1f9c46608109e4df3cd1802b';
String countryCode='in';
String languageCode='en';

class NewsServer {

  List<News> news  = [];

  Future<void> getNews() async{


    String url = "http://newsapi.org/v2/top-headlines?country=$countryCode&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=$languageCode&apiKey=$apiKey";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          News article = News(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}


class NewsForCategory {

  List<News> news  = [];

  Future<void> getNewsForCategory(String category) async{

    String url = "http://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&apiKey=$apiKey";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          News article = News(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}
