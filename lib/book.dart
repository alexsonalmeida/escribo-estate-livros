
import 'package:escribo_estante_livros/service/client.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class Book extends StatefulWidget {
  final Map<String, dynamic> book;
  Book({required this.book});

  @override
  State<Book> createState() => _Book(book);
}

class _Book extends State<Book> {
  final ClientHttp client = ClientHttp();
  final Map<String, dynamic> book;
  bool isFavorite = false;

  _Book(this.book);

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.yellow : null))
        ],
      ),
    );
  }
}
