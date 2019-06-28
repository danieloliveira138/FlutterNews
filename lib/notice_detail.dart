import 'package:flutter/material.dart';

class NoticeDetail extends StatelessWidget{

  var _img;
  var _title;
  var _date;
  var _description;
  BuildContext scaffoldContext;

  NoticeDetail(this._img, this._title, this._date, this._description);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title)
      ),
      body: new Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return new Container(
          margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
          child: new Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(6.0),
            child: new ListView(
              children: <Widget>[
                _getImageNetwork(_img),
                _getBody(_title, _date, _description),
                new MaterialButton(onPressed: (){
                  showSnackBar('Teste');
                },
                  height: 50.0,
                  minWidth: 90.0,
                  color: Colors.green,)
              ],
            ),
          ),
        );
      })

    );
  }

  showSnackBar(message){
    var snackbar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'ok',
          onPressed: () {

          }),
    );
    Scaffold.of(scaffoldContext).showSnackBar(snackbar);
  }

  Widget _getBody(title, date, description) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitle(title),
          _getDate(date),
          _getDescription(description)
        ],
      ),
    );
  }

  Widget _getImageNetwork(url){
    return new Container(
      height: 200.0,
      child: new Image.network(
        url,
        fit: BoxFit.cover
      ),
    );
  }

  _getTitle(title){
    return new Text(
      title,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),
    );
  }

  _getDate(date){
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(
        date,
        style: new TextStyle(
          fontSize: 10.0,
          color: Colors.grey
        ),
      ),
    );
  }

  _getDescription(description){
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: new Text(description),
    );
  }
}