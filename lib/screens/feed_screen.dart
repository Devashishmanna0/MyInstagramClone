import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/global_variable.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //const FeedScreen({Key? Key}) : super(key: Key);
  @override
  Widget build(BuildContext Context) {

    final width = MediaQuery.of(context as BuildContext).size.width;

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: width > webScreenSize
      ? null :AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'Assets/Images/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: (){},
            //icon: FaIcon(FontAwesomeIcons.
            icon: const Icon(
                Icons.messenger_outline_rounded
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? width * 0.3 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data()

              ),
            ),
          );
          },

      ),
    );
  }
}