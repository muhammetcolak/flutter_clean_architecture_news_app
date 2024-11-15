import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_news_app/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/domain/usecases/get_news_articles.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {

final GetArticleUseCase _getArticleUseCase;
  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()) {
    on <GetArticles> (onGetArticles);
  }


  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemoteArticlesDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
    // Debug
    print("errorrrr:");
    print(dataState.error!.message);

      emit(
        RemoteArticlesError(dataState.error!)
      );
    }

  }
}
