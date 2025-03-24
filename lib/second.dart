import 'dart:convert';
import 'dart:io';

import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'network.dart';

class Page1 extends StatefulWidget {
  String url;
  Page1(this.url);
  @override
  @override
  State<StatefulWidget> createState() {
    return _Page1State(this.url);
  }
}

class _Page1State extends State<Page1> {
  var path;
  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    Directory _path = await getApplicationDocumentsDirectory();
    String _localPath = _path.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    path = _localPath;
  }

  String url;
  _Page1State(this.url);
  bool vid = false;
  bool img = false;
  @override
  initState() {
    _setPath();
  }

  Widget build(BuildContext context) {
    RegExp regExp = new RegExp(
      '"post_id":(.*?)\},',
    );
    return Scaffold(
      body: FutureBuilder<String>(
        future: getpostid(url),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return FutureBuilder<String>(
                  future: getvideolink(
                      regExp
                          .firstMatch(snapshot.data!)!
                          .group(0)!
                          .split(":")[1]
                          .split("}")[0]
                          .split('"')[1]
                          .toString(),
                      url),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          print(snapshot.data);
                        return ListView(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        "X",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple[700],
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Text(
                                      "Download",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.file_open_rounded,
                                        color: Colors.purple[700],
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: Image.network(
                                              jsonDecode(snapshot.data!)["data"]
                                                              ["data"]
                                                          ["containing_thread"][
                                                      "thread_items"][0]["post"]
                                                  ["user"]["profile_pic_url"])
                                          .image,
                                      backgroundColor: Colors.grey,
                                      radius: 20.0,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          jsonDecode(snapshot.data!)["data"]
                                                          ["data"]
                                                      ["containing_thread"]
                                                  ["thread_items"][0]["post"]
                                              ["user"]["username"],
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 200,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                //ToDo: To Box
                                Container(
                                  width: 370,
                                  height: 370,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                    image: DecorationImage(
                                      //jsonDecode(snapshot.data!)["data"]["data"]["containing_thread"]["thread_items"][0]["post"]["image_versions2"]["candidates"][0]["url"]
                                      image: Image.network(jsonDecode(snapshot.data!)["data"]["data"]["containing_thread"]["thread_items"][0]["post"]["text_post_app_info"]["share_info"]["reposted_post"] != null
                                              ? jsonDecode(snapshot.data!)["data"]["data"]["containing_thread"]
                                                              ["thread_items"][0]["post"]
                                                          ["text_post_app_info"]["share_info"]
                                                      ["reposted_post"]["image_versions2"]
                                                  ["candidates"][0]["url"]
                                              : jsonDecode(snapshot.data!)["data"]
                                                          ["data"]["containing_thread"]
                                                      ["thread_items"][0]["post"]
                                                  ["image_versions2"]["candidates"][0]["url"])
                                          .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      //SizedBox(width: 70,),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 320, left: 150),
                                        child: Text(
                                          "Theard's Downdloader",
                                          // textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 100),
                                        child: Text(
                                          "Buy Pro Version to remove watermark",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: 300,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      //icon: Icon(Icons.ac_unit),
                                      hintText: url,
                                      enabled: false,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //ToDo: task
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.center,
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //         img = !img;
                                //         });

                                //       },
                                //       child: Container(
                                //         width: 70,
                                //         height: 36,
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(10),
                                //           border: Border.all(
                                //             color: Colors.black,
                                //           ),
                                //         ),
                                //         child:  Center(
                                //           child: Text(
                                //             "JPG",
                                //             style: TextStyle(
                                //               fontSize: 15,
                                //               color: (img ? Colors.black : Colors),
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox.square(dimension: 10),
                                //     GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //           vid = !vid;
                                //         });
                                //       },
                                //       child: Container(
                                //         width: 70,
                                //         height: 36,
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(10),
                                //           border: Border.all(
                                //             color: Colors.black,
                                //           ),
                                //         ),
                                //         child:  Center(
                                //           child: Text(
                                //             "MP4",
                                //             style: TextStyle(
                                //               fontSize: 15,
                                //               color: (vid ? Colors.black : Colors.grey),
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                //ToDo: Button,
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (jsonDecode(snapshot.data!)["data"]
                                                                ["data"]
                                                            [
                                                            "containing_thread"]
                                                        ["thread_items"][0]
                                                    ["post"]["video_versions"]
                                                .length ==
                                            0) {
                                          await Flowder.download(
                                            jsonDecode(snapshot.data!)["data"]
                                                                    ["data"]
                                                                ["containing_thread"]
                                                            ["thread_items"][0][
                                                        "post"]["text_post_app_info"]
                                                    ["share_info"]["reposted_post"]
                                                ["image_versions2"]["candidates"][0]["url"],
                                            DownloaderUtils(
                                              progressCallback:
                                                  (current, total) {
                                                final progress =
                                                    (current / total) * 100;
                                                print('Downloading: $progress');
                                              },
                                              file: File('$path/' +
                                                  jsonDecode(snapshot.data!)["data"]["data"]["containing_thread"]["thread_items"][0]
                                                                              ["post"]
                                                                          ["text_post_app_info"]
                                                                      ["share_info"]
                                                                  ["reposted_post"]
                                                              ["image_versions2"]
                                                          [
                                                          "candidates"][0]["url"]
                                                      .split("?")[0]
                                                      .split("/")[5]),
                                              progress:
                                                  ProgressImplementation(),
                                              onDone: () {
                                                OpenFile.open('$path/' +
                                                    jsonDecode(snapshot.data!)["data"]["data"]["containing_thread"]["thread_items"][0]["post"]
                                                                            ["text_post_app_info"]
                                                                        ["share_info"]
                                                                    ["reposted_post"]
                                                                [
                                                                "image_versions2"]
                                                            [
                                                            "candidates"][0]["url"]
                                                        .split("?")[0]
                                                        .split("/")[5]);
                                              },
                                              deleteOnCancel: true,
                                            ),
                                          );
                                        } else {
                                          await Flowder.download(
                                            jsonDecode(snapshot.data!)["data"]
                                                            ["data"]
                                                        ["containing_thread"]
                                                    ["thread_items"][0]["post"]
                                                ["video_versions"][0]["url"],
                                            DownloaderUtils(
                                              progressCallback:
                                                  (current, total) {
                                                final progress =
                                                    (current / total) * 100;
                                                print('Downloading: $progress');
                                              },
                                              file: File('$path/' +
                                                  jsonDecode(snapshot.data!)[
                                                                          "data"]
                                                                      ["data"]
                                                                  ["containing_thread"]
                                                              [
                                                              "thread_items"][0]["post"]
                                                          [
                                                          "video_versions"][0]["url"]
                                                      .split("?")[0]
                                                      .split("/")[5]),
                                              progress:
                                                  ProgressImplementation(),
                                              onDone: () {
                                                OpenFile.open('$path/' +
                                                    jsonDecode(snapshot.data!)[
                                                                            "data"]
                                                                        ["data"]
                                                                    ["containing_thread"]
                                                                [
                                                                "thread_items"][0]["post"]
                                                            [
                                                            "video_versions"][0]["url"]
                                                        .split("?")[0]
                                                        .split("/")[5]);
                                              },
                                              deleteOnCancel: true,
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            jsonDecode(snapshot.data!)["data"]
                                                                        ["data"]
                                                                    [
                                                                    "containing_thread"]
                                                                [
                                                                "thread_items"][0]
                                                            [
                                                            "post"]["video_versions"]
                                                        .length ==
                                                    0
                                                ? "Download Image"
                                                : "Download Video",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                    }
                  },
                );
          }
        },
      ),
    );
  }
}
