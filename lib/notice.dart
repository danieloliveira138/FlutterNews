import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  var _img;
  var _title;
  var _date;
  var _description;

  Notice(this._img, this._title, this._date, this._description);
  
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: _getListTitle(),
      ),
    );
  }

  Widget _getListTitle(){
    return Container(
      height: 95.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new FadeInImage.assetNetwork(
              placeholder: '',
              image: _img,
              fit: BoxFit.cover,
              width: 95.0,
              height: 95.0,
          ),
          _getColumText(_title, _date, _description)
        ],
      ),
    );
  }

  Widget _getColumText(title, date, description){
    return new Expanded(
      child: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleWidget(title),
            _getDateWidget(date),
            _getDescriptionWidget(description)
          ],
        ),
      ),);
  }

  Widget _getTitleWidget(String currencyName){
    return new Text(
      currencyName,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold)
    );
  }

  Widget _getDateWidget(String date){
    return new Text(
      date,
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),);
  }

  Widget _getDescriptionWidget(String description){
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(description, maxLines: 2)
    );
  }
}