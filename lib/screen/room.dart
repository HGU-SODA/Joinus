// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../info/user.dart';
import '../themepage/theme.dart';

class Room extends StatefulWidget {
  final String id;
  final String roomimage;
  final String roomtitle;
  final String roommission;

  const Room({
    required this.id,
    required this.roomimage,
    required this.roomtitle,
    required this.roommission,
    Key? key,
  }) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> with SingleTickerProviderStateMixin {
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

  // ignore: unused_field, prefer_final_fields
  TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 349,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                    child: Image.network(
                      widget.roomimage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 62,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                ),
                Positioned(
                  top: 77,
                  right: 25,
                  child: GestureDetector(
                    onTap: () async {
                      _showBottomSheet(context, '1');
                    },
                    child: Container(
                      width: 30,
                      height: 18,
                      child: Image.asset('assets/images/kebap.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 236,
                  left: 25,
                  child: Container(
                    child: Text(widget.roomtitle,
                        style: whitew700.copyWith(
                          fontSize: 24.0,
                        )),
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 25,
                  child: Container(
                    width: 159,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3), // 반지름 값을 설정합니다.
                      color: Color.fromRGBO(255, 239, 244, 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12, bottom: 3),
                          child: Text(widget.roommission,
                              style: pinkw700.copyWith(
                                fontSize: 16.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 317),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            width: 230,
                            height: 50,
                            child: TabBar(
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  width: 2, // Bottom line width
                                ), // Bottom line padding
                                borderRadius: BorderRadius.circular(
                                    2), // Adjust the radius as needed
                              ),
                              indicatorWeight: 3,
                              indicatorColor: Color.fromRGBO(36, 38, 37, 1),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding: EdgeInsets.only(
                                  bottom: 1), // Adjust horizontal padding
                              controller: _tabController,
                              // label color
                              labelColor: Color.fromRGBO(36, 38, 37, 1),
                              // unselected label color
                              unselectedLabelColor:
                                  Color.fromARGB(255, 151, 151, 151),
                              tabs: [
                                Container(
                                  width: 90, // Adjust tab width as needed
                                  child: Tab(
                                    child: Text(
                                      '미션인증',
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 18, // Font size
                                        fontWeight:
                                            FontWeight.w700, // Font weight 700
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90, // Adjust tab width as needed
                                  child: Tab(
                                    child: Text(
                                      '보관함',
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 18, // Font size
                                        fontWeight:
                                            FontWeight.w700, // Font weight 700
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 100),
                        ],
                      ),
                      Divider(
                          height: 0, color: Color.fromRGBO(170, 170, 170, 1))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 485,
              width: 393,
              child: TabBarView(
                controller: _tabController,
                children: [
                  MissionTab(
                    id: widget.id,
                  ),
                  StorageTab(
                    id: widget.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 160,
          child: Container(
            margin: EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 343,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF242625),
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 모서리 반경 설정
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showDeleteConfirmationDialog(context);
                    },
                    child: Text(
                      "삭제",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Color.fromRGBO(239, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  width: 343,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF242625),
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 모서리 반경 설정
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(36, 38, 37, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.transparent,
          contentPadding: EdgeInsets.all(0), // padding을 0으로 설정
          insetPadding: EdgeInsets.all(16), // 화면 주변 padding 설정
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            width: 343, // 원하는 가로 길이 설정
            height: 139, // 원하는 세로 길이 설정
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 29),
                Text("이 글을 정말 삭제하시겠어요?",
                    style: blackw500.copyWith(fontSize: 18)),
                SizedBox(height: 31),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 131,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Color(0xFF808080),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6), // 모서리 반경 설정
                          ),
                        ),
                        child:
                            Text("취소", style: whitew700.copyWith(fontSize: 14)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Color(0xFFEF597D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6), // 모서리 반경 설정
                          ),
                        ),
                        child:
                            Text("삭제", style: whitew700.copyWith(fontSize: 14)),
                        onPressed: () async {
                          try {
                            // Replace "Biginfo" with the actual collection name
                            await FirebaseFirestore.instance
                                .collection("Biginfo")
                                .doc(widget.id)
                                .delete();
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          } catch (e) {
                            print("Error deleting document: $e");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MissionTab extends StatefulWidget {
  final String id;
  const MissionTab({super.key, required this.id});
  @override
  State<MissionTab> createState() => MissionTabState();
}

class MissionTabState extends State<MissionTab> {
  final firestore = FirebaseFirestore.instance;
  XFile? _pickedFile;
  String? roomDataId;
  String? userindex;

  int? image_count;
  int? check_count = 0;
  var scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _imageSize = MediaQuery.of(context).size.width / 4;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('Biginfo').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        final filteredDocs =
            docs.where((doc) => doc['id'] == widget.id).toList();

        // Now you can use filteredDocs to display data from Firestore
        if (filteredDocs.isNotEmpty) {
          final roomSnapshot = filteredDocs.first;
          final roomData = roomSnapshot.data();

          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        '인증 기간',
                        style:
                            greyw500.copyWith(fontSize: 16, letterSpacing: -1),
                      ),
                      SizedBox(width: 153),
                      Text(
                        '인증 시간',
                        style:
                            greyw500.copyWith(fontSize: 16, letterSpacing: -1),
                      )
                    ]),
                    SizedBox(height: 15),
                    Row(children: [
                      Text(
                        roomData['start_date'] + ' ~ ' + roomData['end_date'],
                        style:
                            blackw700.copyWith(fontSize: 16, letterSpacing: -1),
                      ),
                      SizedBox(width: 72),
                      Text(
                        roomData['start_time'] + ' ~ ' + roomData['end_time'],
                        style:
                            blackw700.copyWith(fontSize: 16, letterSpacing: -1),
                      ),
                    ]),
                    SizedBox(height: 30),
                    Text(
                      '참여 코드',
                      style: greyw500.copyWith(fontSize: 16, letterSpacing: -1),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 343,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color.fromRGBO(239, 239, 239, 1),
                      ),
                      child: Center(
                        child: Text(
                          roomData['code'],
                          style: blackw700.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    GridView.builder(
                      padding: EdgeInsets.only(top: 44),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13,
                      ),
                      itemCount: roomData['users_name'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final userName =
                            roomData['users_name'][index] as String;

                        final temp = roomData['users_id'][index];
                        image_count = roomData['users_name'].length;

                        return GestureDetector(
                            onTap: UserProvider.userId !=
                                    roomData['users_id'][index]
                                ? () {}
                                : () async {
                                    _showBottomSheet();
                                    setState(() {
                                      roomDataId = roomData['id'];
                                      userindex = roomData['users_id'][index];
                                    });
                                  },
                            child: Container(
                              width: 165,
                              height: 165,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (roomData['users_image'][temp] != null)
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.6),
                                        BlendMode.darken,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          roomData['users_image'][temp],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  if (roomData['users_image'][temp] == null)
                                    Container(
                                      color: Color.fromRGBO(239, 239, 239, 1),
                                      child: Center(
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: _imageSize,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    top: 7,
                                    left: 12,
                                    child: Text(
                                      userName,
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: roomData['users_image'][temp] !=
                                                null
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  if (roomData['users_image'][temp] != null)
                                    Center(
                                      child: Image.asset(
                                        'assets/images/ei_check.jpg',
                                        width: 50, // 이미지의 가로 크기 조절
                                        height: 50, // 이미지의 세로 크기 조절
                                      ),
                                    )
                                ],
                              ),
                            ));
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: check_count == image_count
                          ? null
                          : () {
                              _showStyledSnackBar(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffEF597D),
                        disabledBackgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Container(
                        width: 343,
                        height: 45,
                        child: Center(
                          child: Text(
                            '완료하기',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text('No data found.');
        }
      },
    );
  }

  void _showStyledSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🥳 미션을 성공했어요!',
            style: TextStyle(
              color: Color(0xFFEF597D), //글씨는 분명히 보여야 함으로 투명도 미적용
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFEFF4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: EdgeInsets.only(
        left: 72.0,
        right: 72.0,
        bottom: 84,
      ),
      elevation: 0.0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Container(
            height: 278,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23), color: Colors.white),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23), color: Colors.white),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        width: 48,
                        height: 3.346,
                        decoration: BoxDecoration(
                          color: Color(0xFFAAAAAA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 14),
                      child: Text(
                        '방에 들어갈 이미지는 무엇인가요?',
                        style:
                            blackw700.copyWith(fontSize: 18, letterSpacing: -1),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 25),
                      child: Text(
                        "이미지를 가져올 곳을 선택해주세요",
                        style:
                            greyw500.copyWith(fontSize: 14, letterSpacing: -1),
                      ),
                    ),
                    Container(
                      width: 343,
                      height: 60,
                      margin: EdgeInsets.only(left: 25, right: 25, top: 38),
                      child: ElevatedButton(
                        onPressed: () {
                          _getPhotoLibraryImage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // 버튼 모서리 둥글기 설정
                          ),
                          elevation: 0, // 이 부분을 추가하여 쉐도우 없앰
                          backgroundColor: Color.fromRGBO(255, 239, 244, 1),
                        ),
                        child: Text(
                          '갤러리',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(239, 89, 125, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      _uploadImageToFirebase();
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  String? _uploadedImageUrl; // 업로드 된 이미지 URL 저장 변수 추가
  Future<void> _uploadImageToFirebase() async {
    await Firebase.initializeApp();

    if (_pickedFile == null) {
      if (kDebugMode) {
        print('이미지가 선택되지 않았습니다.');
      }
      return;
    }

    final imageBytes = await File(_pickedFile!.path).readAsBytes();
    final imageName = DateTime.now().second.toString() + '.jpg';
    final storageReference = FirebaseStorage.instance.ref(imageName);

    try {
      await storageReference.putData(imageBytes);
      final TaskSnapshot taskSnapshot =
          await storageReference.putData(imageBytes);
      final imageUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _uploadedImageUrl = imageUrl;
      });
      print(roomDataId);
      print(userindex);
      final docRef = firestore.collection('Biginfo').doc(roomDataId);
      DocumentSnapshot snapshot = await docRef.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      Map<String, dynamic> usersImage = data['users_image'] ?? {};
      usersImage[userindex!] = _uploadedImageUrl!;

      await docRef.update({
        'users_image': usersImage,
      });
    } catch (e) {
      if (kDebugMode) {
        print('이미지 업로드 실패: $e');
      }
    }
  }
}

class StorageTab extends StatefulWidget {
  final String id;
  const StorageTab({super.key, required this.id});
  @override
  State<StorageTab> createState() => StorageTabState();
}

class StorageTabState extends State<StorageTab> {
  final firestore = FirebaseFirestore.instance;
  String? roomDataId;
  String? userindex;
  var scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('Biginfo').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        final filteredDocs =
            docs.where((doc) => doc['id'] == widget.id).toList();

        // Now you can use filteredDocs to display data from Firestore
        if (filteredDocs.isNotEmpty) {
          final roomSnapshot = filteredDocs.first;
          final roomData = roomSnapshot.data();

          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.only(top: 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemCount: roomData['users_name'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final temp = roomData['users_id'][index];

                        final Timestamp timestamp = roomData['register-time'];
                        DateTime dateTime = timestamp.toDate();
                        String formattedDateTime =
                            DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 111,
                              height: 111,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.6),
                                      BlendMode.darken,
                                    ),
                                    child: ClipRRect(
                                      child: Image.network(
                                        roomData['users_image'][temp],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 20,
                                    child: Text(
                                      formattedDateTime,
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: roomData['users_image'][temp] !=
                                                null
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text('No data found.');
        }
      },
    );
  }
}
