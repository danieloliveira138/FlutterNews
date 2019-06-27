import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/notice_list.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Flutter News',
      theme: new ThemeData(
        primarySwatch: Colors.purple
      ),
      home: new NoticeList(),
      routes: <String, WidgetBuilder> {

      },
    );
  }
}
