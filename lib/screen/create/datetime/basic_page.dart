// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'room_datetime.dart';

class SetDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          iconSize: 24.0,
          color: Color(0xFF242625),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: RoomMaker6(),
      ),
    );
  }
}

class RoomMaker6 extends StatefulWidget {
  @override
  _MyContentWidgetState createState() => _MyContentWidgetState();
}

class _MyContentWidgetState extends State<RoomMaker6> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
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
              SizedBox(height: 26),
              RangeDatePickerWidget(),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
