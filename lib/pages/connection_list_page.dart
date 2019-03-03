import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kubernetes_mobile_dashboard/data/connection.dart';
import 'package:kubernetes_mobile_dashboard/pages/new_connection_page.dart';
import 'package:path_provider/path_provider.dart';

class ConnectionListPage extends StatefulWidget {
  ConnectionListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConnectionListPageState createState() => _ConnectionListPageState();
}

class _ConnectionListPageState extends State<ConnectionListPage> {
  List<Card> _connectionCards = List();

  @override
  void initState() {
    super.initState();

    _getConnectionCards().then((result) {
      setState(() {
        _connectionCards = result;
      });
    });
  }

  Future<List<Card>> _getConnectionCards() async {
    List<Connection> connections = await _getConnectionList();
    List<Card> cards = List(connections.length);
    for (Connection connection in connections) {
      cards.add(Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(connection.name),
              subtitle: Text(connection.url),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                  children: new List.from(this._connectionCards)
                    ..add(
                      FlatButton(
                        child: const Text('Connect'),
                        onPressed: () {
                          print("Connect to " + connection.name);
                        },
                      ),
                    )),
            ),
          ],
        ),
      ));
    }
    return cards;
  }

  Future<List<Connection>> _getConnectionList() async {
    final directory = await getApplicationDocumentsDirectory();
    File connectionsFile = File(directory.path + "/connections.json");
    if (!await connectionsFile.exists()) {
      return new List<Connection>();
    }
    String connectionsJson = connectionsFile.readAsStringSync();
    List<Connection> connections = new List();
    for (var connectionJson in jsonDecode(connectionsJson)["connections"]) {
      connections.add(Connection.fromJson(connectionJson));
    }
    return connections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              child: Text("Add new connection"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewConnectionPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
