import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable{}

class FetchArticlesEvent extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}