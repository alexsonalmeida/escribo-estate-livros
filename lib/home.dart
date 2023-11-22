import 'package:escribo_estante_livros/book.dart';
import 'package:flutter/material.dart';
import 'package:escribo_estante_livros/service/client.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ClientHttp client = ClientHttp();
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> result = await client.fetchData();
      setState(() {
        books = result;
      });
    } catch (e) {
      print('Erro na api: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        mainAxisSpacing: 2.0,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        childAspectRatio: 3 / 4,
        children: books.map((book) => Book(book: book)).toList(),
      ),
    );
  }
}
