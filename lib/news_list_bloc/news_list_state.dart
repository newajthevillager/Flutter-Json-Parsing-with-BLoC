import 'package:boring_flutter_app/model/article_model.dart';

abstract class NewsListState {}

class NewsListFetchingState extends NewsListState {}

class NewsListFethingErrorState extends NewsListState {
  String message;

  NewsListFethingErrorState({this.message});

}

class NoNewsListState extends NewsListState {}

class NewsListFetchedState extends NewsListState {

  List<Article> articles;

  NewsListFetchedState ({this.articles});

}