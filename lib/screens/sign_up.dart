import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/response/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/utils.dart';
import '../response/Mobile_screen_layout.dart';
import '../response/responsive.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;


  @override

  void navigateToLogin(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _bioController.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
   Uint8List img =  await pickImage(ImageSource.gallery);
   setState(() {
      _image = img;
   });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().SignUpUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if(res != 'Success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext){
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding:   EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(),flex: 2),
                // svg image
                SvgPicture.asset('Assets/Images/ic_instagram.svg',
                  //color: Colors.white,
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 64,),
                //accept image from gallery
                Stack(
                  children: [
                    _image != null ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                        : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://www.bing.com/images/search?view=detailV2&ccid=Z5BlhFYs&id=3CB9EA571ECF75C4EF9E39079C91A16254A94879&thid=OIP.Z5BlhFYs_ga1fZnBWkcKjQHaHz&mediaurl=https%3a%2f%2fwww.pngarts.com%2ffiles%2f10%2fDefault-Profile-Picture-PNG-Download-Image.png&exph=1457&expw=1383&q=default+profile+image&simid=607994578831231822&FORM=IRPRST&ck=927DC4E2C4CE0290E5A15A1F8F072E59&selectedIndex=0'
                      ),
                    ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                              Icons.add_a_photo,
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 24,),
                //text field for input for username
                TextFieldInput(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernamecontroller,
                ),
                const SizedBox(height: 24,),
                // text field input for E-mail
                TextFieldInput(
                  hintText: 'Enter your e-mail',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailcontroller,
                ),
                const SizedBox(height: 24,),
                // text field input for password
                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordcontroller,
                  isPass: true,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  textEditingController: _bioController,
                ),
                const SizedBox(height: 24,),
                // button login
                InkWell(
                  onTap: signUpUser,

                     /* () async {
                    String res = await AuthMethod().SignUpUser(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                        username: _usernamecontroller.text,
                        bio: _bioController.text,
                        file: _image!,
                    );
                    print(res);
                    },*/
                  child: Container(

                    child: _isLoading ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                        : const Text('Sign up'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4),),
                    ),
                      color: blueColor,
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Flexible(child: Container(),flex: 2),
                // transtioning to signing up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Dont have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),

                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: Text("Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    )

                  ],
                )
              ],
            ),
          )),
    );
  }
}