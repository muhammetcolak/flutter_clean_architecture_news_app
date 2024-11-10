import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/data/repositories/article_repository_impl.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/domain/usecases/get_news_articles.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl())
  );


  // UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl())
  );


  // Blocs
  sl.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(sl())
  );
}