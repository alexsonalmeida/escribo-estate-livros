import 'dart:convert';
import 'dart:io';
import 'package:escribo_estante_livros/epub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class ClientHttp {
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse("https://escribo.com/books.json"));

    if (response.statusCode == 200) {
      return json.decode(response
          .body); // Return a Map<String, dynamic> from the JSON response
    } else {
      throw Exception('Falha ao carregar dados da API');
    }
  }

  Future<void> downloadOrReadBook(book, BuildContext context) async {
    final dio = Dio();
    final fileName = book['title']; // Nome do arquivo local
    final urlDownload = book['download_url'];
    final pathAbsolute = path.join(Directory.systemTemp.path, '$fileName.epub');

    final File file = File(pathAbsolute);

    if (!file.existsSync()) {
      await dio.download(urlDownload, pathAbsolute).whenComplete(
            () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Epub(path: pathAbsolute))
              ),
          );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Epub(path: pathAbsolute),
        ),
      );
    }
  }
}
