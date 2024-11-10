import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_news_app/core/constants/constants.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_news_app/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_news_app/features/daily_news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try{
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }

}