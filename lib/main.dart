import 'package:boring_flutter_app/model/article_model.dart';
import 'package:boring_flutter_app/news_list_bloc/news_list_bloc.dart';
import 'package:boring_flutter_app/news_list_bloc/news_list_event.dart';
import 'package:boring_flutter_app/news_list_bloc/news_list_state.dart';
import 'package:boring_flutter_app/services/article_api_provider.dart';
import 'package:boring_flutter_app/services/article_repository.dart';
import 'package:boring_flutter_app/ui/about_screen.dart';
import 'package:boring_flutter_app/ui/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  ArticleRepository articleRepository = ArticleRepository();
  runApp(HomePage(
    articleRepository: articleRepository,
  ));
}

class HomePage extends StatefulWidget {
  final ArticleRepository articleRepository;

  HomePage({this.articleRepository});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NewsListBloc _newsListBloc;

  // constructor will be called before initState()
  _HomePageState() {
    print("C called");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Cricket"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AboutScreen();
                        }),
                      );
                    },
                  )
                ],
              ),
              body: Container(
                child: buildUI(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    return BlocBuilder(
      bloc: _newsListBloc,
      builder: (context, state) {
        if (state is NewsListFetchingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsListFethingErrorState) {
          return Center(
            child: Text("Error Found"),
          );
        } else if (state is NoNewsListState) {
          return Center(
            child: Text("No News"),
          );
        } else if (state is NewsListFetchedState) {
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (ctx, pos) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      state.articles[pos].urlToImage,
                      fit: BoxFit.cover,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                  title: Text(state.articles[pos].title),
                  subtitle: Text(state.articles[pos].publishedAt),
                ),
              );
            },
          );
        }
      },
    );
  }

  // using FutureBuilder without BLoC pattern
//   List<Article> list = [];
//  Widget loadUI(BuildContext ctx) {
//    _articleRepository.getCricNews().then((articles) {
//      for (var a in articles) {
//        list.add(a);
//      }
//      print("LLL ${list.length}");
//    });
//    return FutureBuilder(
//      future: _articleRepository.getCricNews(),
//      builder: (ctx, snapshot) {
//        if (snapshot.data == null) {
//          return Container(
//              alignment: Alignment.center, child: CircularProgressIndicator());
//        } else {
//          return Container(
//            child: ListView.builder(
//              itemCount: 10,
//              itemBuilder: (ctx, pos) {
//                return Card(
//                  child: InkWell(
//                    onTap: () {},
//                    splashColor: Colors.grey,
//                    child: ListTile(
//                      leading: Image.network(
//                        list[pos].urlToImage,
//                        width: 80.0,
//                        height: 80.0,
//                        fit: BoxFit.cover,
//                      ),
//                      title: Text(list[pos].title),
//                      subtitle: Text(
//                        list[pos].publishedAt,
//                        textAlign: TextAlign.end,
//                      ),
//                    ),
//                  ),
//                );
//              },
//            ),
//          );
//        }
//      },
//    );
//  }

  @override
  void initState() {
    super.initState();
    print("M called");
    _newsListBloc = NewsListBloc(articleRepository: widget.articleRepository);
    _newsListBloc.dispatch(AvailableNetworkEvent());
  }

  @override
  void dispose() {
    _newsListBloc.dispose();
    super.dispose();
  }
}

void navigateToContentScreen(BuildContext context, String headline,
    String imageUrl, String time, String content) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return ContentScreen(
      headline: headline,
      imageUrl: imageUrl,
      content: content,
      time: time,
    );
  }));
}
