import 'package:anitocorn_work_shop_json_feed/services/auth_service.dart';
import 'package:anitocorn_work_shop_json_feed/services/network.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  List<String> dummy = List<String>.generate(20, (index) => "Row: ${index}");

  @override
  Widget build(BuildContext context) {
    Network.fetchYoutube();
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/background17.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: _listSection(),
      ),
    );
  }

  _listSection() => ListView.builder(
        itemCount: dummy.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _headerImageSection();
          }
          return Card(
            margin: const EdgeInsets.only(
              bottom: 10.0,
              right: 20.0,
              left: 20.0,
            ),
            child: Column(
              children: [
                _headerSectionCard(),
                _bodySectionCard(),
                _footerSectionCard(),
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
  _headerSectionCard() => ListTile(
        leading: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              "assets/uniswap.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          "Phenomenal",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        subtitle: const Text(
          "Blog",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
  _bodySectionCard() => Image.asset(
        "assets/background19.jpg",
        fit: BoxFit.cover,
      );

  _footerSectionCard() => Row(
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
      ));
}
