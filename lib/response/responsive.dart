import 'package:flutter/material.dart';
import 'package:instagram/utils/global_variable.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
      }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth > webScreenSize){
            return widget.webScreenLayout;
            // web screen
          } else{
            return widget.mobileScreenLayout;
            //mobile screen
          }

        }
    );
  }
}