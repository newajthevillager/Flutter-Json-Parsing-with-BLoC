import 'package:bloc/bloc.dart';
import 'package:boring_flutter_app/bloc/article/article_event.dart';
import 'package:boring_flutter_app/bloc/article/article_state.dart';
import 'package:boring_flutter_app/data/model/api_result_model.dart';
import 'package:boring_flutter_app/data/repository/article_repository.dart';
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  ArticleRepository repository;

  ArticleBloc({@required this.repository});

  @override
  // TODO: implement initialState
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }

}