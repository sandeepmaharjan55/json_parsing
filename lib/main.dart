import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();
  List _dataProgress = await getJSONprogress();
  // print(_dataProgress[0]["coins"]);
  //  for (var i = 0; i < _dataProgress.length; i++) {
  //  print(_dataProgress[i]["coins"].sort());
  // }
  // _dataProgress[0]["coins"].sort();
  // _dataProgress.sort((a, b) {
  //   return a.value['coins'].compareTo(b.value['coins']);
  // });

  // print(_data[0]);
  // print(_data[0]["body"]);
  // for (var i = 0; i < _dataProgress.length; i++) {
  //   print("Title: ${_dataProgress[i]["coins"]}");
  // }
  _getGreencoins(String s) {
    String greencoins = "0";
    for (var i = 0; i < _dataProgress.length; i++) {
      if ('${_dataProgress[i]["detail"]}' == s) {
        // print(s);
        // print('${_dataProgress[i]["detail"]}');
        greencoins = '${_dataProgress[i]["coins"]}';
        // print(greencoins);
        break;
      } else {
        greencoins = "0";
      }
      // print(greencoins);
      // print("Title: ${_dataProgress[i]["coins"]}");
    }
    return greencoins;
  }

  _getSteps(String s) {
    String steps = "0";
    double kmsteps = 0;
    for (var i = 0; i < _dataProgress.length; i++) {
      if ('${_dataProgress[i]["detail"]}' == s) {
        // print(s);
        // print('${_dataProgress[i]["detail"]}');
        kmsteps = _dataProgress[i]["distance"] * 0.0008;
        // print(kmsteps);
        steps = kmsteps.toStringAsFixed(1);
        // print(greencoins);
        break;
      } else {
        steps = "0";
      }
      // print(greencoins);
      // print("Title: ${_dataProgress[i]["coins"]}");
    }
    return steps + "km";
  }

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: AppBar(
        title: Text("Json Users"),
        backgroundColor: Colors.orangeAccent,
      ),
      // listView builder
      body: ListView.builder(
        itemCount: _data.length,
        padding: const EdgeInsets.all(3.0),
        itemBuilder: (BuildContext context, int position) {
          return Column(children: <Widget>[
            Divider(
              height: 3.4,
            ),
            ListTile(
              title: Center(
                child: Text(
                  "${_data[position]['user_name']}",
                  style: TextStyle(fontSize: 17.2, fontWeight: FontWeight.bold),
                ),
              ),
              // contentPadding: const EdgeInsets.all(30.0),
              subtitle: new Column(
                children: <Widget>[
                  // Row(
                  //   children: [
                  //     new Image.network("${_data[position]['user_img']}",
                  //         height: 70, width: 70),
                  //     new Text(
                  //       "${_data[position]['fb_id']}",
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Container(
                      //   child: new Image.network(
                      //     "${_data[position]['user_img']}",
                      //     height: 70,
                      //     width: 70,
                      //   ),
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage('${_data[position]['user_img']}'),
                          height: 70,
                          width: 70,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Green Coins",
                              style: TextStyle(
                                  fontSize: 17.2, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _getGreencoins('${_data[position]['_id']}'),
                              style: TextStyle(
                                  fontSize: 17.2, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Walked",
                              style: TextStyle(
                                  fontSize: 17.2, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _getSteps('${_data[position]['_id']}'),
                              style: TextStyle(
                                  fontSize: 17.2, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // contentPadding: const EdgeInsets.all(30.0),
                      // subtitle: Text('${_data.length}'),
                    ],
                  ),
                ],
              ),
              // leading: CircleAvatar(),
              onTap: () => showTapMessage(context, _data[position]['user_name'],
                  _data[position]['user_img']),
            ),
          ]);
        },
      ),
    ),
  ));
}

void showTapMessage(BuildContext context, String message, String image) {
  var alertDialog = new AlertDialog(
    title: Text(message),
    content: Image.network(image),
    actions: [
      FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("OK"),
      )
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}

Future<List> getJSON() async {
  String apiURL = "#";
  http.Response response = await http.get(apiURL);
  // print(json.decode(response.body));
  return json.decode(response.body)['details'];
}

Future<List> getJSONprogress() async {
  String apiURL = "#";
  http.Response response = await http.get(apiURL);
  // print(json.decode(response.body));
  return json.decode(response.body)['docs'];
}

// _getGreencoins(String s) {
//   for (var i = 0; i < _dataProgress.length; i++) {
//     print("Title: ${_dataProgress[i]["coins"]}");
//   }
//   return s;
// }

// _getSteps(String s) {
//   return s;
// }
