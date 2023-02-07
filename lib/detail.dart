// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:anitocorn_work_shop_json_feed/models/youtubes.dart';
import 'package:transparent_image/transparent_image.dart';

class Detail extends StatelessWidget {
  Youtube? youtube;

  Detail({
    Key? key,
    this.youtube,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: ListView(
        children: [
          _headerImageSection(),
          _bodySection(),
        ],
      ),
    );
  }

  _headerImageSection() => FadeInImage.memoryNetwork(
        height: 180.0,
        width: double.infinity,
        placeholder: kTransparentImage,
        image: youtube!.youtubeImage,
        fit: BoxFit.cover,
      );

  _bodySection() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              youtube!.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
            const Divider(),
            Row(
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  margin: const EdgeInsets.only(right: 12.0),
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: youtube!.avatarImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Phenomenal",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "Published on Feb 7, 2023",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {},
                  child: Text(
                    "Sibscript 200K".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
