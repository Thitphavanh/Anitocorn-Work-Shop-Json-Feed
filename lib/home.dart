import 'package:anitocorn_work_shop_json_feed/models/youtubes.dart';
import 'package:anitocorn_work_shop_json_feed/services/auth_service.dart';
import 'package:anitocorn_work_shop_json_feed/services/network.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  final typeArray = const ["superhero", "foods", "songs", "traning"];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  int index = 0;
  String? type;

  @override
  void initState() {
    super.initState();
    type = typeArray[index];
  }

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
                child: RefreshIndicator(
                  key: _refresh,
                  child: _listSection(youtubes: snapshot.data),
                  onRefresh: _handleRefresh,
                ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: "reload",
        onPressed: () {
          if (index >= typeArray.length - 1) {
            index = 0;
          } else {
            index++;
          }
          type = typeArray[index];

          _refresh.currentState!.show();
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );

          _handleRefresh();
        },
        child: const Icon(
          Icons.refresh,
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    setState(() {});
  }

  _listSection({List<Youtube>? youtubes}) => ListView.builder(
        controller: _scrollController,
        itemCount: youtubes!.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _headerImageSection();
          }

          var item = youtubes[index];

          bool last = youtubes.length == (index + 1);

          return Card(
            margin: last
                ? const EdgeInsets.only(
                    bottom: 90.0,
                    right: 20.0,
                    left: 20.0,
                  )
                : const EdgeInsets.only(
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
  _bodySectionCard({Youtube? youtube}) => GestureDetector(
        onTap: () {
          launchURL(youtubeId: youtube.id);
        },
        child: FadeInImage.memoryNetwork(
          height: 180.0,
          width: double.infinity,
          placeholder: kTransparentImage,
          image: youtube!.youtubeImage,
          fit: BoxFit.cover,
        ),
      );

  _footerSectionCard({Youtube? youtube}) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _customElevatedButton(
            iconData: Icons.thumb_up,
            label: "Like",
            colors: Colors.black,
          ),
          _customElevatedButton(
            iconData: Icons.share,
            label: "Share",
            colors: Colors.black,
          ),
        ],
      );
  _customElevatedButton({IconData? iconData, String? label, Color? colors}) =>
      TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              iconData,
              color: colors,
            ),
            const SizedBox(width: 8.0),
            Text(
              label!,
              style: TextStyle(
                color: colors,
              ),
            ),
          ],
        ),
      );

  launchURL({String? youtubeId}) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=${youtubeId}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
