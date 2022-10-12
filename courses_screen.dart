import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:untitled19/controller/programs_controller.dart';
import 'package:untitled19/screens/videos_screen.dart';
import 'package:untitled19/screens/pdf_files_screen.dart';

import '../classes/courses.dart';
import '../constants/colors.dart';
ProgramsController controller=Get.put(ProgramsController());
class CoursesScreen extends StatefulWidget {
  int even=0;
  IconData searchIcon=Icons.search;
bool searchClick=false;
TextEditingController searchController=TextEditingController();
List<String> courses=List.generate(controller.programs[0].courses.length, (index) => controller.programs[0].courses[index].courseName);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {

  @override
  Widget build(BuildContext context) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: [
              IconButton(onPressed: (){
                widget.even%2==0?
                setState(() {
                 widget.searchClick=true;
                 widget.searchIcon=Icons.close;
                 widget.even++;
                }):
                 setState(() {
                widget.searchClick=false;
                widget.searchIcon=Icons.search;
                 widget.even++;
                });
              }, icon: Icon(widget.searchIcon))
              ],
              backgroundColor: COLOR2,
              elevation: 0,
              title: Text("إختر المادة",style: GoogleFonts.notoKufiArabic(fontSize: 18),),
            ),
              backgroundColor: COLOR2,
              body:
               widget.searchClick==true?
                   Column(
                     children:[
               const SizedBox(
                 height: 20,
               ),
              Container(margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: TextField(
          onChanged: (value) => controller.filterPlayer(value),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: COLOR1),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: COLOR3),
            ),
            labelText: "ابحث عن اسم المادة"
            ,labelStyle: GoogleFonts.notoKufiArabic(fontSize: 18,color: COLOR1),
          ),
          cursorColor: COLOR1,
          style: TextStyle(color: Colors.white,fontSize: 20),
        ),
      ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                      () => ListView.builder(
                    itemCount: controller.foundCourses.value.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: (){
                        Get.to(PdfFilesScreen(verify: index));
                      },
                      title: Text(
                        controller.foundCourses.value[index],
                        style:
                        GoogleFonts.notoKufiArabic(fontSize: 18,color: COLOR3),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
             ])
             : GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  children: [
                    ...controller.programs[0].courses.map((p) =>
                        TextButton(
                          onPressed: () {
                            Get.to(PdfFilesScreen(verify: p.id,));
                            // controller.currentProduct = p.item[p.id];
                            // index=p.id;
                          },
                          child: Container(margin: EdgeInsets.symmetric(horizontal: 5),child:Image.asset(p.courseImage,height: 300,width: 400,fit: BoxFit.fitHeight),height: 799,width: 200,)
                        )
                    ),
                  ]
              )
          )
      );
    }
}
