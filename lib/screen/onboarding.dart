import 'package:flutter/material.dart';
import '/screen/account/login.dart';
import '/themepage/theme.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class onboarding extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<onboarding> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = 4; // Change the page count to 4
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    selectedPage = page;
                  });
                },
                children: List.generate(pageCount, (index) {
                  return MyPageContent(index: index);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 24, right: 24, bottom: 18),
              child: PageViewDotIndicator(
                size: const Size(10, 10),
                unselectedSize: const Size(10, 10),
                currentItem: selectedPage,
                count: pageCount,
                unselectedColor:
                    const Color.fromRGBO(128, 128, 128, 1), // #808080
                selectedColor: const Color.fromRGBO(255, 73, 117, 1), // #FF4975
                boxShape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPageContent extends StatelessWidget {
  final int index;

  MyPageContent({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return FirstPageContent();
      case 1:
        return SecondPageContent();
      case 2:
        return ThirdPageContent();
      default:
        return FourthPageContent();
    }
  }
}

class FirstPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("미션을 선택하고\n우리만의 미션 방을 만들어요",
              textAlign: TextAlign.center,
              style: blackw700.copyWith(fontSize: 24)),
          const SizedBox(
            height: 26,
          ),
          Container(
            height: 605.0,
            child: Image.asset('assets/onboarding1.png'),
          )
        ],
      ),
    );
  }
}

class SecondPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("인증 기간과 시간에 맞추어\n미션을 인증해요",
              textAlign: TextAlign.center,
              style: blackw700.copyWith(fontSize: 24)),
          const SizedBox(
            height: 26,
          ),
          Container(
            height: 605.0,
            child: Image.asset('assets/onboarding2.png'),
          )
        ],
      ),
    );
  }
}

class ThirdPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("매일 꾸준한 미션인증으로\n생활습관을 잡아봐요",
              textAlign: TextAlign.center,
              style: blackw700.copyWith(fontSize: 24)),
          const SizedBox(
            height: 26,
          ),
          Container(
            height: 605.0,
            child: Image.asset('assets/onboarding3.png'),
          )
        ],
      ),
    );
  }
}

class FourthPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("방 인원 모두가 사진을 업로드하면\n미션인증에 성공해요",
                textAlign: TextAlign.center,
                style: blackw700.copyWith(fontSize: 24)),
            const SizedBox(
              height: 26,
            ),
            Container(
              height: 605.0,
              child: Image.asset('assets/onboarding4.png'),
            )
          ],
        ),
      ),
    );
  }
}
