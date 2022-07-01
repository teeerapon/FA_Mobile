import 'package:flutter/material.dart';
import 'package:new_flutter_test/service/shared_service.dart';
import 'package:new_flutter_test/sceen/login_sceen.dart';
import 'sceen/permission_branch.dart';

// Widget _defaultHome = const LohinSceen();
Widget _defaultHome = const LohinSceen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    // _defaultHome = const LohinSceen();
    _defaultHome = const PermissionBranch();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const LohinSceen(),
        '/permission_branch': (context) => const PermissionBranch(),
      },
    );
  }
}
