// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';

import '../../../info/big.dart';
import '../../../themepage/theme.dart';
import 'create_image.dart';

const double _kItemExtent = 32.0;
List<String> _AM_PM = <String>[
  '오전',
  '오후',
];
List<String> _hours = List<String>.generate(
    12, (index) => (index + 1).toString().padLeft(2, '0'));
List<String> _minute =
    List<String>.generate(60, (index) => index.toString().padLeft(2, '0'));

class RangeDatePickerWidget extends StatefulWidget {
  @override
  RangeDatePickerWidgetState createState() => RangeDatePickerWidgetState();
}

class RangeDatePickerWidgetState extends State<RangeDatePickerWidget> {
  int _selected_AM_PM = 0;
  int _selected_hours = 0;
  int _selected_minute = 0;

  int _selected_AM_PM2 = 0;
  int _selected_hours2 = 0;
  int _selected_minute2 = 0;

  String starttime = ''; //선택된 시작 시간
  String starttime2 = ''; //선택된 종료 시간

  void _showDialog({required bool forFirstButton}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: BorderRadius.circular(23)),
        height: MediaQuery.of(context).size.height * 0.2 + 70,
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 18),
                  width: 48,
                  height: 3.346,
                  decoration: BoxDecoration(
                    color: Color(0xFFAAAAAA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  width: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 33,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 239, 244, 1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: _buildPicker_AM(
                                  _AM_PM,
                                  forFirstButton
                                      ? _selected_AM_PM
                                      : _selected_AM_PM2,
                                  forFirstButton: forFirstButton)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ":",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                              child: _buildPicker(
                                  _hours,
                                  forFirstButton
                                      ? _selected_hours
                                      : _selected_hours2,
                                  forFirstButton: forFirstButton)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ":",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                              child: _buildPicker(
                                  _minute,
                                  forFirstButton
                                      ? _selected_minute
                                      : _selected_minute2,
                                  forFirstButton: forFirstButton)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPicker(List<String> items, int selectedItem,
      {required bool forFirstButton}) {
    return CupertinoPicker(
      magnification: 1.3, //준) 확대율 설정
      looping: true,
      selectionOverlay: null,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(
        initialItem: selectedItem,
      ),
      onSelectedItemChanged: (int selectedItem) {
        setState(() {
          if (forFirstButton) {
            if (items == _AM_PM) {
              _selected_AM_PM = selectedItem;
            } else if (items == _hours) {
              _selected_hours = selectedItem;
            } else if (items == _minute) {
              _selected_minute = selectedItem;
            }
            starttime =
                '${_AM_PM[_selected_AM_PM]} ${_hours[_selected_hours]}시';
          } else {
            if (items == _AM_PM) {
              _selected_AM_PM2 = selectedItem;
            } else if (items == _hours) {
              _selected_hours2 = selectedItem;
            } else if (items == _minute) {
              _selected_minute2 = selectedItem;
            }
            starttime2 =
                '${_AM_PM[_selected_AM_PM2]} ${_hours[_selected_hours2]}시';
          }
        });
      },
      children: List<Widget>.generate(
        items.length,
        (int index) {
          return Center(
              child: Text(
            items[index],
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 17, //준) 글씨 크기 변화
            ),
          ));
        },
      ),
    );
  }

  Widget _buildPicker_AM(List<String> items, int selectedItem,
      {required bool forFirstButton}) {
    return CupertinoPicker(
      magnification: 1.3, //준) 확대율 설정
      looping: false,
      selectionOverlay: null,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(
        initialItem: selectedItem,
      ),
      onSelectedItemChanged: (int selectedItem) {
        setState(() {
          if (forFirstButton) {
            if (items == _AM_PM) {
              _selected_AM_PM = selectedItem;
            } else if (items == _hours) {
              _selected_hours = selectedItem;
            } else if (items == _minute) {
              _selected_minute = selectedItem;
            }
            starttime =
                '${_AM_PM[_selected_AM_PM]} ${_hours[_selected_hours]}시';
          } else {
            if (items == _AM_PM) {
              _selected_AM_PM2 = selectedItem;
            } else if (items == _hours) {
              _selected_hours2 = selectedItem;
            } else if (items == _minute) {
              _selected_minute2 = selectedItem;
            }
            starttime2 =
                '${_AM_PM[_selected_AM_PM2]} ${_hours[_selected_hours2]}시';
          }
        });
      },
      children: List<Widget>.generate(
        items.length,
        (int index) {
          return Center(
              child: Text(
            items[index],
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 18,
            ),
          ));
        },
      ),
    );
  }

  Widget _buildButton(
      {required VoidCallback onPressed, required String timeString}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all(Size(165, 43)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFAFAFA)),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            } else {
              return Colors.black;
            }
          },
        ),
      ),
      child: Row(
        children: [
          Text(
            timeString,
            style: TextStyle(
              fontFamily: 'Pretendard',
              letterSpacing: -0.5,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: timeString.startsWith("시작 시간") ||
                      timeString.startsWith("종료 시간")
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  bool isCalendarVisible = false;
  List<DateTime?> selectedDates = [];
  int check = 0;
  get values => null;
  Color _startButtonColor() {
    return isCalendarVisible && selectedDates.isNotEmpty
        ? Color(0xFFFAFAFA)
        : Color(0xFFFAFAFA);
  }

  Color _endButtonColor() {
    return isCalendarVisible && selectedDates.isNotEmpty
        ? Color(0xFFFAFAFA)
        : Color(0xFFFAFAFA);
  }

  Color _buttonTextColor1() {
    return selectedDates.isNotEmpty ? Colors.black : Color(0xFFAAAAAA);
  }

  Color _buttonTextColor2() {
    return selectedDates.isNotEmpty ? Colors.black : Color(0xFFAAAAAA);
  }

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Color(0xFFEF597D),
      selectedDayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      weekdayLabels: ['일', '월', '화', '수', '목', '금', '토'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      calendarType: CalendarDatePicker2Type.range,
      selectableDayPredicate: (day) =>
          day.isAfter(DateTime.now().subtract(Duration(days: 1))),
    );

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("같이할 기간은 언제부터인가요?",
              style: blackw700.copyWith(
                fontSize: 24,
              )),
          SizedBox(height: 5),
          Text(
            "같이할 기간과 시간을 선택할 수 있어요",
            style: greyw500.copyWith(fontSize: 16, letterSpacing: -0.5),
          ),
          SizedBox(height: 35),
          Text(
            "기간",
            style: blackw700.copyWith(fontSize: 18, letterSpacing: -0.5),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "인증 시작",
                    style:
                        blackw500.copyWith(fontSize: 12, letterSpacing: -0.5),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCalendarVisible = !isCalendarVisible;
                      });
                    },
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(165, 43)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _startButtonColor()),
                        elevation: MaterialStateProperty.all(0)),
                    child: Row(
                      children: [
                        Text(
                          isCalendarVisible || selectedDates.isNotEmpty
                              ? _getValueText_start(
                                  config.calendarType,
                                  selectedDates,
                                )
                              : '시작 날짜',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _buttonTextColor1(),
                              letterSpacing: -0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "인증 종료",
                    style:
                        blackw500.copyWith(fontSize: 12, letterSpacing: -0.5),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCalendarVisible = !isCalendarVisible;
                      });
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      fixedSize: MaterialStateProperty.all(Size(165, 43)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(_endButtonColor()),
                    ),
                    child: Row(
                      children: [
                        Text(
                          isCalendarVisible || selectedDates.isNotEmpty
                              ? _getValueText_end(
                                  config.calendarType,
                                  selectedDates,
                                )
                              : '종료 날짜',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _buttonTextColor2(),
                              fontFamily: 'Pretendard',
                              letterSpacing: -0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: isCalendarVisible,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Color(0xFFFFEFF4),
              ),
              child: Column(
                children: [
                  CalendarDatePicker2(
                    config: config,
                    value: selectedDates,
                    onValueChanged: (dates) => setState(() {
                      selectedDates = dates;
                    }),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !isCalendarVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Text(
                  "시간",
                  style: blackw700.copyWith(fontSize: 18, letterSpacing: -0.5),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "인증 시작",
                            style: blackw500.copyWith(
                                fontSize: 12, letterSpacing: -0.5),
                          ),
                          _buildButton(
                            onPressed: () => _showDialog(forFirstButton: true),
                            timeString: starttime.isEmpty
                                ? "시작 시간"
                                : '${_AM_PM[_selected_AM_PM]}:${_hours[_selected_hours]}:${_minute[_selected_minute]}',
                          ), //버튼 위치
                        ]),
                    Expanded(child: SizedBox()),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "인증 종료",
                            style: blackw500.copyWith(
                                fontSize: 12, letterSpacing: -0.5),
                          ),
                          _buildButton(
                            onPressed: () => _showDialog(forFirstButton: false),
                            timeString: starttime2.isEmpty
                                ? "종료 시간"
                                : '${_AM_PM[_selected_AM_PM2]}:${_hours[_selected_hours2]}:${_minute[_selected_minute2]}',
                          ), //버튼 위치
                        ]),
                  ],
                ),
                SizedBox(height: 260),
                Container(
                  margin: EdgeInsets.only(bottom: 37),
                  child: ElevatedButton(
                    onPressed: _getValueText_start(
                                  config.calendarType,
                                  selectedDates,
                                ) !=
                                '시작 날짜' &&
                            _getValueText_end(
                                  config.calendarType,
                                  selectedDates,
                                ) !=
                                '종료 날짜' &&
                            starttime != '' &&
                            starttime2 != ''
                        ? () {
                            BigInfoProvider.start_date = _getValueText_start(
                              config.calendarType,
                              selectedDates,
                            );
                            BigInfoProvider.end_date = _getValueText_end(
                              config.calendarType,
                              selectedDates,
                            );
                            BigInfoProvider.start_time = starttime;
                            BigInfoProvider.end_time = starttime2;
                            _showEnterRoomBottomSheet(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
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
                      style: TextStyle(fontSize: 16, color: Colors.white),
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

  String _getValueText_start(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();

    if (values.isEmpty) {
      return '시작 날짜';
    }
    var formatDate;
    var valueText = values[0]?.toString()?.replaceAll('00:00:00.000', '');
    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1]?.toString()?.replaceAll('00:00:00.000', '') ?? 'null'
            : 'null';
        valueText = '$startDate';

        formatDate = DateFormat('yy.MM.dd').format(values[0]!);
      } else {
        return 'null';
      }
    }
    if (values.length > 1 &&
        values[0]?.day == DateTime.now().day &&
        values[1]?.day == DateTime.now().day) {
      valueText = values[0]?.day.toString();
      formatDate = DateFormat('yy.MM.dd').format(values[0]!);
    }
    return formatDate ?? 'null';
  }

  String _getValueText_end(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    if (values.isEmpty) {
      return '종료 날짜';
    }
    var endformat;
    var valueText = values[0]?.toString()?.replaceAll('00:00:00.000', '');
    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? DateFormat('yy.MM.dd').format(values[1]!)
            : '종료 날짜';
        valueText = '$endDate';
      } else {
        return 'null';
      }
    }
    if (values.length > 1 &&
        values[0]?.day == DateTime.now().day &&
        values[1]?.day == DateTime.now().day) {
      valueText = values[0]?.day.toString();
    }
    return valueText ?? 'null';
  }

  void _showEnterRoomBottomSheet(BuildContext context) {
    bool isConfirmButtonEnabled = false;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return RoomImageSet();
      },
    );
  }
}
