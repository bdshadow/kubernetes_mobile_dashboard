import 'package:flutter/material.dart';

class NewConnectionPage extends StatefulWidget {
  NewConnectionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewConnectionPageState();
}

enum AuthType { token, basic }

class _NewConnectionPageState extends State<NewConnectionPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthType authType = AuthType.token;
  bool ignoreCertificateCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New connection"),
        ),
        body: Builder(builder: (BuildContext context) {
          // From Scaffold/of docs:
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of(). Look at ignoreCertificateButton
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ListView(children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "URL"),
                controller: _urlController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                          title: const Text("Token"),
                          groupValue: authType,
                          value: AuthType.token,
                          onChanged: (AuthType value) {
                            setState(() {
                              authType = value;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: const Text("Basic"),
                          groupValue: authType,
                          value: AuthType.basic,
                          onChanged: (AuthType value) {
                            setState(() {
                              authType = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Visibility(
                  maintainAnimation: false,
                  maintainSemantics: false,
                  maintainSize: false,
                  maintainInteractivity: false,
                  maintainState: false,
                  visible: authType == AuthType.token,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: "Token"),
                        controller: _tokenController,
                      )
                    ],
                  ),
                  replacement: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: "Username"),
                        controller: _usernameController,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Password"),
                        controller: _passwordController,
                      ),
                    ],
                  )),
              CheckboxListTile(
                title: Text(
                  "Ignore secure certificate check",
                  style: ignoreCertificateCheck
                      ? TextStyle(color: Colors.red)
                      : TextStyle(),
                ),
                value: ignoreCertificateCheck,
                onChanged: (bool value) {
                  setState(() {
                    ignoreCertificateCheck = value;
                  });
                  if (ignoreCertificateCheck) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(
                          "Use it only for trusted connection, e.g. your local running minishift"),
                      action: SnackBarAction(
                          label: "Explain more", onPressed: () {}),
                    ));
                  } else {
                    Scaffold.of(context).hideCurrentSnackBar();
                  }
                },
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Connect"),
                    onPressed: () {
                      print("Try connect");
                    },
                  ),
                ),
              )
            ]),
          );
        }));
  }
}
