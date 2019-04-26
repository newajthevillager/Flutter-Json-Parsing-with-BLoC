import 'package:boring_flutter_app/model/api_result.dart';
import 'package:boring_flutter_app/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ArticleApiProvider {

  String cricNewsUrl =
      "https://newsapi.org/v2/top-headlines?sources=espn-cric-info&apiKey=2555c574c98f4fa18c6b579402d78d3b";
  List<Article> cricNewsList = [];

  Future<List<Article>> getCricNews() async {
    var response = await http.get(cricNewsUrl);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      cricNewsList = ApiResult.fromJson(data).articles;

      for (Article a in cricNewsList) {
        print("News : ${a.title}");
      }

      return cricNewsList;
    } else {
      print("Error");
    }
  }

}