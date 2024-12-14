import 'package:educonecta/widgets/bottom_navigation.dart';
import 'package:educonecta/widgets/box_courses.dart';
import 'package:educonecta/widgets/story_box.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String? userName;

  HomePage({super.key, this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> cardData = [
    'Free e-book 1',
    'Free e-book 1',
    'Free e-book 1',
    'Free e-book 1',
    'Free e-book 1'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset('assets/avatar.png', fit: BoxFit.cover,),
        leadingWidth: 70,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 85),
              child: Text(
                'Hello, ${widget.userName}!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text(
                '+1600 Points',
                style: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: openDialog,
              icon: Icon(Icons.notifications_active_outlined),
              iconSize: 28,
            ),
          )
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StoryBox(
                    image: DecorationImage(
                        image: AssetImage('assets/profile5.jpeg'),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StoryBox(
                    image: DecorationImage(
                        image: AssetImage('assets/profile2.jpg'),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StoryBox(
                    image: DecorationImage(
                        image: AssetImage('assets/profile3.png'),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StoryBox(
                    image: DecorationImage(
                        image: AssetImage('assets/profile4.png'),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StoryBox(
                    image: DecorationImage(
                        image: AssetImage('assets/profile5.jpeg'),
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Upcoming',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'course of this week',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BoxCourses(),
            // ignore: sized_box_for_whitespace
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 400,
                child: ScrollSnapList(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      _buildCardItem(context, index, cardData),
                  itemCount: cardData.length,
                  itemSize:
                      600,
                  onItemFocus: (index) {},
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Notifications'),
            content: Text('No exist notifications'),
            actions: [
              TextButton(onPressed: submit, child: Text('Submit'))
            ],
          ));

  void submit() {
    Get.back();
  }
}

Widget _buildCardItem(BuildContext context, int index, List<String> cardData) {
  return Padding(
    padding:
        const EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [
        Image.asset(
          'assets/background.png',
          width: 320,
          height: 600,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 30),
          child: Container(
            width: 115,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.greenAccent[400],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                cardData[index],
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 230, left: 30),
          child: Text(
            'Step design print for\n beginner',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
    ),
  );
}
