// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../themepage/theme.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        margin: EdgeInsets.only(left: 25, top: 92, right: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "조이너스의 회원이 되신 걸",
                style: blackw700.copyWith(fontSize: 26),
              ),
              Text(
                "축하드립니다!",
                style: blackw700.copyWith(fontSize: 26),
              ),
            ],
          ),
          SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "조이너스와 함께 규칙적인 습관을",
                style: greyw500.copyWith(fontSize: 14),
              ),
              Text(
                "만들어보세요.",
                style: greyw500.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 40),
          Image.asset('assets/images/welcome.png'),
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginPage())));
            },
            child: Container(
              width: 343,
              height: 52,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor),
              child: Center(
                child: Text(
                  '시작하기',
                  style: whitew700.copyWith(fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(height: 39)
        ]),
      ),
    );
  }
}
