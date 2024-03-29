import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/response/Mobile_screen_layout.dart';
import 'package:instagram/response/responsive.dart';
import 'package:instagram/screens/sign_up.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variable.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_field_input.dart';
import 'package:instagram/resources/auth_methods.dart';

import '../response/web_screen_layout.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override

  void navigateToSignUp(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ),
    );
  }


  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );

    if(res == "success"){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext){
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: MediaQuery.of(context).size.width > webScreenSize? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3)
            : const  EdgeInsets.symmetric(horizontal: 32),
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
                // button login
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading ? const Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    )
                        : const Text('Log in'),
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
                      onTap: navigateToSignUp,
                      child: Container(
                        child: Text(" Sign up.",
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