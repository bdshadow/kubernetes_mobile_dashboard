import 'package:flutter/material.dart';
import 'package:kubernetes_mobile_dashboard/pages/connection_list_page.dart';

void main() => runApp(KubernetesAndroidDashboard());

class KubernetesAndroidDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kubernetes Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectionListPage(title: 'Connections'),
    );
  }
}
