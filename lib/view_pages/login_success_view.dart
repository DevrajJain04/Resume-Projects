import 'package:flutter/material.dart';
import 'package:weatherapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  MyDashboardState createState() => MyDashboardState();
}

class MyDashboardState extends State<MyDashboard> {
  SharedPreferences? logindata;
  String? username;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata?.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here's ur Information !!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hey $username, what would u like to see today then?',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cityname/');
                },
                child: const Text('for real time weather')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/contacts/');
                },
                child:const Text('Contact List')),
            ElevatedButton(
              onPressed: () {
                logindata?.setBool('login', true);
                Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) => MyLoginPage()));
              },
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
