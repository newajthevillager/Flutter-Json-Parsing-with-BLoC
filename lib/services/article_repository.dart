import 'package:boring_flutter_app/model/article_model.dart';
import 'package:boring_flutter_app/services/article_api_provider.dart';

class ArticleRepository {
  ArticleApiProvider articleApiProvider = ArticleApiProvider();

  Future<List<Article>> getCricNews() async {
   return articleApiProvider.getCricNews();
  }
}
