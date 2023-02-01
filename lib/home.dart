import 'package:anitocorn_work_shop_json_feed/models/youtubes.dart';
import 'package:anitocorn_work_shop_json_feed/services/auth_service.dart';
import 'package:anitocorn_work_shop_json_feed/services/network.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();

  String type = "superhero";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();

              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Youtube>>(
          future: Network.fetchYoutube(type: type),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/background17.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: _listSection(youtubes: snapshot.data),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _listSection({List<Youtube>? youtubes}) => ListView.builder(
        itemCount: youtubes!.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _headerImageSection();
          }

          var item = youtubes[index];
          return Card(
            margin: const EdgeInsets.only(
              bottom: 10.0,
              right: 20.0,
              left: 20.0,
            ),
            child: Column(
              children: [
                _headerSectionCard(youtube: item),
                _bodySectionCard(youtube: item),
                _footerSectionCard(youtube: item),
              ],
            ),
          );
        },
      );

  _headerImageSection() => Padding(
        padding: const EdgeInsets.fromLTRB(
          20.0,
          10.0,
          20.0,
          10.0,
        ),
        child: Image.asset(
          "assets/phenomenal.jpg",
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      );
  _headerSectionCard({Youtube? youtube}) => ListTile(
        leading: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: youtube!.avatarImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          youtube.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          youtube.subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
  _bodySectionCard({Youtube? youtube}) => FadeInImage.memoryNetwork(
        height: 180.0,
        width: double.infinity,
        placeholder: kTransparentImage,
        image: youtube!.youtubeImage,
        fit: BoxFit.cover,
      );

  _footerSectionCard({Youtube? youtube}) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _customElevatedButton(iconData: Icons.thumb_up, label: "Like"),
          _customElevatedButton(iconData: Icons.share, label: "Share"),
        ],
      );
  _customElevatedButton({IconData? iconData, String? label}) => TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 8.0),
            Text(label!),
          ],
        ),
      );
}
