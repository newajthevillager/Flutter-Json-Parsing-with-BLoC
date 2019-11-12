import 'package:boring_flutter_app/data/model/api_result.dart';
import 'package:boring_flutter_app/data/model/article_model.dart';
import 'package:boring_flutter_app/res/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class  ArticleRepository {
  Future<List<Article>> fetchArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {

  @override
  Future<List<Article>> fetchArticles() async {

    var response = await http.get(AppStrings.cricArticleUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> cricNewsList = ApiResult.fromJson(data).articles;
      for (Article a in cricNewsList) {
        print("News : ${a.title}");
      }
      return cricNewsList;
    } else {
      throw Exception();
    }
  }
}