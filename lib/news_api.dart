import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
    String url = "https://raw.githubusercontent.com/RafaelBarbosatec/tutorial_flutter_medium/master/api/news.json";

    Future<List> loadNews() async {
      try {
        http.Response response = await http.get(url);

        const JsonDecoder decoder = const JsonDecoder();
        return decoder.convert(response.body);

      } on Exception catch(_){
        return null;
      }
    }
}