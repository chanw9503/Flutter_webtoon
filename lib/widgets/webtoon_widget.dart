import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  static const headerAgent =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('take me homeeee');
      },
      child: Column(
        children: [
          Container(
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
              thumb,
              headers: const {
                "User-Agent": headerAgent,
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
