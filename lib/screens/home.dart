import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../class/resqRespShows.dart' as respShow;

class Homemenu extends StatefulWidget {
  const Homemenu({key});

  @override
  State<Homemenu> createState() => _HomemenuState();
}

class _HomemenuState extends State<Homemenu> {
  var resqReq;
  var resp;

  getShowInfo() async {
    var url = Uri.parse('https://api.tvmaze.com/shows');

    try {
      await http.get(url, headers: {
        'Content-type': "application/json; charset-UTF-8",
        'Accept': 'application/json'
      }).then((response) {
        setState(() {
          resqReq = jsonDecode(response.body);
          print(resqReq[0]);
          resp = respShow.showsFromMap(response.body);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getShowInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TV SHOWS'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SizedBox(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.5),
                itemCount: resqReq == null ? 0 : resqReq.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildItemGrid(resqReq[index]));
                },
              ),
            ),
          ),
        ));
  }
}

@override
Widget buildItemGrid(Map resqReq) {
  return GestureDetector(
    onTap: () async {},
    child: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(50))),
          child: Image.network(
            resqReq["image"]['medium'] ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 130,
            color: Colors.black.withOpacity(0.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resqReq['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        resqReq['language'],
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        resqReq['genres'].toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        resqReq['status'],
                        style: resqReq['status'] == 'Ended'
                            ? const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)
                            : const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
