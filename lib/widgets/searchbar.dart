import 'package:flutter/material.dart';
import 'package:pixelhub/screens/wall_view.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);
  TextEditingController searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.78,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.64,
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
                cursorColor:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18)),
                controller: searchCtrl,
                onEditingComplete: () {
                  if (searchCtrl.text.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WallView(query: searchCtrl.text),
                      ),
                    );
                  }
                },
              ),
            ),
            Icon(
              Icons.search_rounded,
              size: 30,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
