import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/global_variable.dart';

import '../utils/colors.dart';

class  WebScreenLayout extends StatefulWidget{
  const WebScreenLayout ({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState(){
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });

  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'Assets/Images/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            //icon: FaIcon(FontAwesomeIcons.
            icon: Icon(
                Icons.home,
              color: _page == 0? primaryColor: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(1),
            //icon: FaIcon(FontAwesomeIcons.
            icon: Icon(
                Icons.search,
              color: _page == 1? primaryColor: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(2),
            //icon: FaIcon(FontAwesomeIcons.
            icon: Icon(
                Icons.add_a_photo,
              color: _page == 2? primaryColor: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(3),
            //icon: FaIcon(FontAwesomeIcons.
            icon: Icon(
                Icons.favorite,
              color: _page == 3? primaryColor: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(4),
            //icon: FaIcon(FontAwesomeIcons.
            icon: Icon(
                Icons.person,
              color: _page == 4? primaryColor: secondaryColor,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}