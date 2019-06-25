import 'package:flutter/material.dart';
import 'package:flutter_news/news_api.dart';
import 'package:flutter_news/notice.dart';

class NoticeList extends StatefulWidget{

  final state = new _NoticeListPageState();
  
  @override
  _NoticeListPageState createState() => state;
    
}

class _NoticeListPageState extends State<NoticeList>{

  List _categorys = new List();
  var _category_selected = 0;

  List _news = new List();
  var repository = new NewsApi();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _getListCategory(),
            new Expanded(
              child: _getListViewWidget(),
            )
          ],
        )
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  @override
  void initState() {
    setCategorys();
    loadNotices();
  }

  Widget _getListCategory(){

    ListView listView = new ListView.builder(
      itemCount: _categorys.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _buildCategoryItem(index);
      }
    );

    return new Container(
      height: 55.0,
      child: listView,
    );
  }

  Widget _buildCategoryItem(int index) {

    return new GestureDetector(
      onTap: (){
        onTabCategory(index);
      },
      child: new Center(
        child: new Container(
          margin: new EdgeInsets.only(left: 10.0),
          child: new Material(
            elevation: 18.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            clipBehavior: Clip.antiAlias,
            child: new Container(
              padding: new EdgeInsets.only(left: 12.0, top: 7.0, bottom: 7.0, right: 12.0),
              color: _category_selected == index ? Colors.blue[800] : Colors.blue[500],
              child: new Text(
                _categorys[index],
                style: new TextStyle(color: Colors.white),
              )
            ),
          ),
        ),
      ),
    );
  }

  void onTabCategory(int index){
    setState(() {
      _category_selected = index;
    });
    //Todo -> Action when user select a category
  }

  void setCategorys() {
    _categorys.add("Geral");
    _categorys.add("Esporte");
    _categorys.add("Tecnologia");
    _categorys.add("Entretenimento");
    _categorys.add("Saúde");
    _categorys.add("Negócios");
  }

  Widget _getBottomNavigationBar(){

    return new BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      items: [
        new BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          title: Text('Recentes'),
          backgroundColor: Colors.green
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          title: Text('Notícias'),
          backgroundColor: Colors.blue
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          title: Text('Sobre'),
          backgroundColor: Colors.red
        )
      ],
    );
  }

  Widget _getListViewWidget(){
    var list = new ListView.builder(
      itemCount: _news.length,
      padding: new EdgeInsets.only(top: 5.0),
      itemBuilder: (context, index){
        return _news[index];
      },
    );

    return list;
  }

  loadNotices() async {
    List result = await repository.loadNews();

    setState(() {
      result.forEach((item) {
        var notice = new Notice(
            item['url_img'],
            item['tittle'],
            item['date'],
            item['description']
        );
        _news.add(notice);
      });
    });
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}