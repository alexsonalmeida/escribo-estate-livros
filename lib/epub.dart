import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Epub extends StatelessWidget {
  final String path;
  Epub({required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle (
              backgroundColor: MaterialStatePropertyAll(Colors.blue[900]),
            ),
            onPressed: () async {
              VocsyEpub.setConfig(
                themeColor: Theme.of(context).primaryColor,
                identifier: "iosBook",
                scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                allowSharing: true,
                enableTts: true,
                nightMode: true,
              );
              VocsyEpub.locatorStream.listen((locator) {
                print('LOCATOR: $locator');
              });
              VocsyEpub.open(
                path,
              );
            },
            child: Text('Abrir Epub', style: TextStyle(color: Colors.white),),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue[900])
            ),
            child: Text("Voltar à estante", style: TextStyle(color: Colors.white))
          )
        ],
    );
  }
}
