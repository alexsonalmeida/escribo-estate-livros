import 'package:flutter/material.dart';

class FavoritesSingleton {
  static final FavoritesSingleton _instance = FavoritesSingleton._internal();

  factory FavoritesSingleton() {
    return _instance;
  }

  FavoritesSingleton._internal();

  Map<int, bool> _favorites = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false
  };

  Map<int, bool> get favorites => _favorites;

  void toggleFavorite(int bookId) {
    _favorites[bookId] = !_favorites[bookId]!;
  }
}