import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final List<String> nouns = [
  'Time',
  'Year',
  'People',
  'Way',
  'Day',
  'May',
  'Thing',
  'Woman',
  'Life',
  'Child',
  'World',
  'School',
  'State',
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final words = nouns.take(50).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite App'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('favorites').listenable(),
        builder: (BuildContext context, Box<dynamic> box, Widget? child) {
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
              final word = words.elementAt(index);
              final isFavorite = box.get(index) != null;
              return ListTile(
                title: Text(word),
                trailing: IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    if (isFavorite) {
                      await box.delete(index);
                      final snackBar = SnackBar(
                        content: const Text('Removed Successfully'),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await box.put(index, word);
                      final snackBar = SnackBar(
                        content: const Text('Added Successfully'),
                        backgroundColor: Colors.blue,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
