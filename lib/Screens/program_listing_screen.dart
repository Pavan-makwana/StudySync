import 'package:flutter/material.dart';

class ProgramListingScreen extends StatelessWidget {
  const ProgramListingScreen({super.key});
  
  final List<String> courses = const <String>['Python Beginner Course', 'Flutter + Dart Intermediate Course ', 'Java Advanced Course', 'Data Science with R', 'Web Development with JavaScript', 'Machine Learning Basics', 'Cybersecurity Fundamentals', 'Cloud Computing with AWS', 'Mobile App Development with React Native', 'Database Management with SQL'];
  final List<String> courseInstructors = const <String>['Patricia Lopez', 'Charles Gonzalez', 'Jennifer Wilson', 'Daniel Anderson', 'Elizabeth Thomas', 'Matthew Taylor', 'Susan Moore', 'Anthony Jackson', 'Margaret White', 'Mark Harris'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FA),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF4C94DC),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        title: const Text(
          "Program Listing",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 24,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        physics:ClampingScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: Color(0xffffffff),
            title: Text(
              courses[index],
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.start,
            ),
            subtitle: Text(
              courseInstructors[index],
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color.fromARGB(255, 158, 158, 158),
              ),
              textAlign: TextAlign.start,
            ),
            dense: false,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            selected: false,
            selectedTileColor: Color(0x42000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF8B8B8B),
              size: 24,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 12),
      ),
      // body: ListView(
      //   scrollDirection: Axis.vertical,
      //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      //   shrinkWrap: false,
      //   physics: ClampingScrollPhysics(),
      //   separatorBuilder: (BuildContext context, int index) =>
      //       SizedBox(height: 8),
      //   children: [
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //     ListTile(
      //       tileColor: Color(0xffffffff),
      //       title: Text(
      //         "Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       subtitle: Text(
      //         "Sub Title",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w400,
      //           fontStyle: FontStyle.normal,
      //           fontSize: 14,
      //           color: Color(0xff000000),
      //         ),
      //         textAlign: TextAlign.start,
      //       ),
      //       dense: false,
      //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      //       selected: false,
      //       selectedTileColor: Color(0x42000000),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
      //       ),
      //       trailing: Icon(
      //         Icons.arrow_forward_ios,
      //         color: Color(0xFF8B8B8B),
      //         size: 24,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}