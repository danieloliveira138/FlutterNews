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
  var _progressBar = false;

  List _news = new List();
  var repository = new NewsApi();
  var _currentIndex = 0;
  var _context = null;

  @override
  Widget build(BuildContext context){
    _context = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Flutter News",
          style: new TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 30.0,
              letterSpacing: 2.0,
              wordSpacing: 10.0),
        ),
      ),
      body: new Stack(
        children: _buildBody(_context)
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  List<Widget> _buildBody(BuildContext context){
    Form form = new Form(
      child: new Column(
        children: [
          _getListCategory(),
          new Expanded(
            child: _getListViewWidget(),
          ),
        ],
      ),
    );

    var llWidget = new List<Widget>();
    llWidget.add(form);

    if(_progressBar){
      var modal = new Stack(
        children: [
          new Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          )
        ],
      );
      llWidget.add(modal);
    }

    return llWidget;
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
            elevation: 5.0,
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
          backgroundColor: Colors.green,
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          title: Text('Notícias'),
          backgroundColor: Colors.blue
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          title: Text('Sobre'),
          backgroundColor: Colors.red,
          activeIcon: const Icon(Icons.add_to_home_screen)
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
    setState(() {
      _progressBar = true;
    });
    List result = await repository.loadNews();
    _progressBar = false;
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
      _progressBar = false;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}