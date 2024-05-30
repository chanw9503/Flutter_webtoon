import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon.dart';

//Stateless 위젯이므로 안에 있는 변수와 메서드들은 static으로 정의 

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //에러 처리는 어떻게 하는거지? try/catch 없나?
  //비동기로 처리되기 때문에 Futre 타이븡로 나중에 나올 값을 정의한다.
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //response.body가 원래 리턴해주는 값은 String이다. 그래서 Json 형식대로 사용하기
      //위해 jsonDecode 메서드를 사용한다.
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel(webtoon));
        // webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }

    throw Error();
  }
}
