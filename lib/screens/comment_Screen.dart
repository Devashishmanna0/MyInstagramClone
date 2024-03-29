import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:instagram/resources/fireStore_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/comment_card.dart';
import 'package:provider/provider.dart';
import '../Models/User.dart';
import '../providers/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen>{
  final TextEditingController _commentcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data()
            ),);
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16,right: 8),
          child:  Row(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.photoUrl
                  ),
                  radius: 18,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: TextField(
                    controller: _commentcontroller,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.Username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  FireStoreMethods().postComment(
                      widget.snap['postId'],
                      _commentcontroller.text,
                      user.Uid,
                      user.Username,
                      user.photoUrl
                  );
                  setState(() {
                    _commentcontroller.text = "";
                  });
              },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8 ),
                  child: const Text('Post',style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}