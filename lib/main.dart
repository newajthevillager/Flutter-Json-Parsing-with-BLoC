import 'package:boring_flutter_app/bloc/article/article_bloc.dart';
import 'package:boring_flutter_app/data/repository/article_repository.dart';
import 'package:boring_flutter_app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket',
      home: BlocProvider(
        builder: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
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
