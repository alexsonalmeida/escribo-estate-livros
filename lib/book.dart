import 'package:escribo_estante_livros/service/client.dart';
import 'package:escribo_estante_livros/singleton.dart';
import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  final Map<String, dynamic> book;
  final bool showOnlyFavorites;
  Book({required this.book, this.showOnlyFavorites = false});

  @override
  State<Book> createState() => _Book(book);
}

class _Book extends State<Book> {
  final ClientHttp client = ClientHttp();
  final Map<String, dynamic> book;
  final FavoritesSingleton _favoritesSingleton = FavoritesSingleton();

  _Book(this.book);

  @override
  Widget build(BuildContext context) {
    bool isFavorite = _favoritesSingleton.favorites[book['id']] ?? false;

    if (widget.showOnlyFavorites && !isFavorite) {
      return Container(
        width: 0,
        height: 0,
      );
    }

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              client.downloadOrReadBook(book, context);
            },
            child: Container(
              height: 90,
              child: Image.network(book['cover_url']),
            ),
          ),
          ListTile(
            title: Text(
              book['title'],
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              book['author'],
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () {
                _favoritesSingleton.toggleFavorite(book['id']);
                setState(() {});
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.yellow : null,
              ))
        ],
      ),
    );
  }
}
