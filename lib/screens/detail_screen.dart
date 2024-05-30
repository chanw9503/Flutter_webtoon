import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_detail.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  static const headerAgent =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36";

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  //초기화하고 싶은 property가 있지만 constructor에서는 불가능한 경우, 
  //initState를 통해서 할 수 있다. 
  //initState가 항상 build보다 먼저 호출되서. 
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    //stateFullWidget에서는 클래스가 별로 있다. DetailScreen 와
    //_DetailScreenState별개의 클래스에서 작업한다. (상속받는게 다르다)
    // widget을 참조해 데이터를 받을 수 있다.
    webtoon = ApiService.getToonByid(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 250,
                  //본래에는 자식이 부모가 자신의 영역을 침범하는걸 막는데, 이걸적용하면 부모가 자식의
                  //영역에 침범할 수 있다. 그래서 border가 먹는다.
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(10, 10),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Image.network(
                    widget.thumb,
                    headers: const {
                      "User-Agent": DetailScreen.headerAgent,
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
