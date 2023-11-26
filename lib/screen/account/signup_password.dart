// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../info/user.dart';
import '../../data/user_data.dart';
import '../../themepage/theme.dart';
import 'welcome.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final FocusNode _textFieldFocus = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  bool _isTextFieldEmpty = true;
  String _enteredText = '';
  String buttonText = '다음으로';

  @override
  void initState() {
    super.initState();
    _textFieldFocus.addListener(_updateTextFieldState);
  }

  @override
  void dispose() {
    _textFieldFocus.removeListener(_updateTextFieldState);
    _textFieldFocus.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateTextFieldState() {
    setState(() {
      _enteredText = _textEditingController.text;
      _isTextFieldEmpty = _enteredText.isEmpty;
    });
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      if (!_isTextFieldEmpty) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _handleKeyPress,
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEF597D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        height: 4,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFFEFF4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        height: 4,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "비밀번호를 작성해주세요",
                      style: blackw700.copyWith(fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
                TextFormField(
                  maxLength: 15,
                  key: const ValueKey(1),
                  style: blackw500.copyWith(fontSize: 24),
                  decoration: InputDecoration(
                    //준) 선택되지 않은 밑줄 속성
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFEFEFEF)),
                    ),
                    //준) 선택된 밑줄 속성 둘을 일치시켰음
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFEFEFEF)),
                    ),
                    hintText: "비밀번호를 입력해주세요",
                    hintStyle: greyw500.copyWith(fontSize: 24),
                    suffixIcon: _isTextFieldEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.cancel),
                            iconSize: 15,
                            color: Colors.grey,
                            onPressed: () {
                              _textEditingController.clear();
                              setState(() {
                                _enteredText = '';
                                _isTextFieldEmpty = true;
                              });
                            },
                          ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _enteredText = value;
                      _isTextFieldEmpty = value.isEmpty;
                      UserData.user_password = _enteredText;
                    });
                  },
                  onSaved: (value) {
                    _enteredText = value!;
                    UserData.user_password = _enteredText;
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _isTextFieldEmpty
                      ? null
                      : () {
                          _showModalBottomSheet(context);
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xffEF597D),
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: Text(
                    buttonText,
                    style: whitew700.copyWith(fontSize: 16),
                  ),
                ),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GalleryModalContent();
      },
    );
  }
}

class GalleryModalContent extends StatefulWidget {
  @override
  _GalleryModalContentState createState() => _GalleryModalContentState();
}

class _GalleryModalContentState extends State<GalleryModalContent> {
  bool isAgreementChecked1 = false; // Track the checkbox state
  bool isAgreementChecked2 = false;

  final _authentication = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool isGalleryButtonEnabled = isAgreementChecked1 && isAgreementChecked2;

    return Container(
      height: 307,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 3.346,
                  decoration: BoxDecoration(
                    color: Color(0xFFAAAAAA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '조이너스를 쓰려면 동의가 필요해요',
                      style: blackw700.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the checkbox state
                          isAgreementChecked1 = !isAgreementChecked1;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: isAgreementChecked1
                                ? Color(0xFFEF597D)
                                : Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '[필수] 서비스 이용 약관 동의사항 ',
                            style: blackw500.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the checkbox state
                          isAgreementChecked2 = !isAgreementChecked2;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: isAgreementChecked2
                                ? Color(0xFFEF597D)
                                : Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '[필수] 개인정보 수집 및 이용 동의사항 ',
                            style: blackw500.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isGalleryButtonEnabled
                        ? Color(0xFFEF597D)
                        : Color(0xFFAAAAAA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: isGalleryButtonEnabled
                        ? () async {
                            try {
                              // ignore: unused_local_variable
                              UserCredential userCredential =
                                  await _authentication
                                      .createUserWithEmailAndPassword(
                                          email: UserData.user_email as String,
                                          password:
                                              UserData.user_password as String);
                            } catch (e) {
                              print(e);
                            }
                            final user = FirebaseAuth.instance.currentUser!;
                            final db = FirebaseFirestore.instance;
                            final docref = db.collection('user').doc(user.uid);
                            await docref.set({
                              userNameFieldName: UserData.user_name,
                              userEmailFieldName: UserData.user_email,
                              userPasswordFieldName: UserData.user_password,
                              userIdFieldName: user.uid,
                            });
                            final docsnapshot = await docref.get();
                            if (docsnapshot.data() == null) {
                              return;
                            }
                            final datasnapsot = docsnapshot.data()!;

                            UserProvider.userName =
                                datasnapsot[userNameFieldName];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => WelcomePage())));
                          }
                        : () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '동의하기',
                      style: whitew700.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
