import 'package:bloc/bloc.dart';
import 'package:boring_flutter_app/services/article_api_provider.dart';
import 'package:boring_flutter_app/services/article_repository.dart';
import 'news_list_event.dart';
import 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {

  ArticleRepository articleRepository;

  NewsListBloc({this.articleRepository});

  @override
  // TODO: implement initialState
  NewsListState get initialState => NewsListFetchingState();

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    if (event is AvailableNetworkEvent) {
      yield NewsListFetchingState();
      try {
        final list = articleRepository.getCricNews();
        if (list != null) {
          yield NewsListFetchedState(
            articles: await list
          );
        } else {
          yield NoNewsListState();
        }
      } catch(_) {
        NewsListFethingErrorState(
          message: _.toString()
        );
      }
    }
  }

  void onNetworkAvailable(NewsListEvent event) {
    dispatch(event);
  }

  void onNoNetwork() {

  }

}