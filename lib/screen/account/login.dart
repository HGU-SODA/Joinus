// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../themepage/theme.dart';
import '../bottom/bottom.dart';
import '../../info/user.dart';
import 'signup_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 124),
            Container(
                width: 292,
                height: 188,
                child: Image.asset('assets/images/login.png')),
            SizedBox(height: 23.53),
            Container(
                width: 274,
                height: 60,
                child: Image.asset('assets/images/JOINUS.jpg')),
            LoginPagepart(),
          ],
        ),
      ),
    );
  }
}

// 로그인 textfield부분입니다.
class LoginPagepart extends StatefulWidget {
  const LoginPagepart({super.key});

  @override
  State<LoginPagepart> createState() => LoginPagepartState();
}

class LoginPagepartState extends State<LoginPagepart> {
  final _authentication = FirebaseAuth.instance;
  String user_name = '';
  String user_email = '';
  String user_password = '';
  final _formkey = GlobalKey<FormState>();
  void _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            width: 343,
            height: 48,
            margin: EdgeInsets.only(top: 44),
            child: TextFormField(
              key: const ValueKey(4),
              onChanged: (value) {
                setState(() {
                  user_email = value;
                });
              },
              onSaved: (value) {
                user_email = value!;
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(250, 250, 250, 1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(
                          239, 239, 239, 1)), // 1픽셀 두께의 테두리와 색상 설
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(
                          239, 239, 239, 1)), // 1픽셀 두께의 테두리와 색상 설정
                ),
                hintText: '이메일',
                hintStyle: greyw500.copyWith(fontSize: 16),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // 힌트 텍스트와 내용 간격 조정
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            width: 343,
            height: 48,
            margin: EdgeInsets.only(top: 15),
            child: TextFormField(
              obscureText: true, // 준) 적히는 글자가 점으로 가려지게 하는 속성
              key: const ValueKey(5),

              onChanged: (value) {
                setState(() {
                  user_password = value;
                });
              },
              onSaved: (value) {
                user_password = value!;
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(250, 250, 250, 1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(
                          239, 239, 239, 1)), // 1픽셀 두께의 테두리와 색상 설
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(
                          239, 239, 239, 1)), // 1픽셀 두께의 테두리와 색상 설정
                ),
                hintText: '비밀번호',
                hintStyle: greyw500.copyWith(fontSize: 16),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              _tryValidation();
              try {
                // ignore: unused_local_variable
                final credential =
                    await _authentication.signInWithEmailAndPassword(
                        email: user_email, password: user_password);
                log(user_email);
              } catch (e) {
                print(e);
                return;
              }
              final user = FirebaseAuth.instance.currentUser!;
              final documentReference =
                  FirebaseFirestore.instance.collection('user').doc(user.uid);
              final docSnapshot = await documentReference.get();
              if (docSnapshot.exists == true) {
                final datasnapshot = docSnapshot.data();
                UserProvider.userName = datasnapshot![userNameFieldName];
                UserProvider.userId = datasnapshot[userIdFieldName];
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Color(0xFFFFFFFF),
              backgroundColor: Color(0xFFEF597D), // 버튼 내의 아이콘과 텍스트 색상
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 모서리 보더 반경
              ),
              minimumSize: Size(343, 52), // 버튼 크기 설정
            ),
            child: Text('로그인', style: whitew700.copyWith(fontSize: 18)),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SetUsername())));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              // 버튼 내의 아이콘과 텍스트 색상
              backgroundColor: Color(0xFFFFEFF4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 모서리 보더 반경
              ),
              minimumSize: Size(343, 52), // 버튼 크기 설정
            ),
            child: Text('회원가입', style: pinkw700.copyWith(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
