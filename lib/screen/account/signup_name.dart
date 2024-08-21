// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screen/account/signup_email.dart';

import '../../data/user_data.dart';
import '../../themepage/theme.dart';

class SetUsername extends StatefulWidget {
  @override
  _SetUsernameState createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  final FocusNode _textFieldFocus = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  bool _isTextFieldEmpty = true;
  String _enteredText = '';
  String user_name = '';

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
      if (!_isTextFieldEmpty) {
        Navigator.of(context).pop();
      }
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
                      flex: 1,
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
                      flex: 3,
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
                    Text("이름을 알려주세요", style: blackw700.copyWith(fontSize: 24)),
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
                    hintText: "이름을 입력해주세요",
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
                      UserData.user_name = _enteredText;
                    });
                  },
                  onSaved: (value) {
                    _enteredText = value!;
                    UserData.user_name = _enteredText;
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _isTextFieldEmpty
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SetEmail())));
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
                    "다음으로",
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
}
