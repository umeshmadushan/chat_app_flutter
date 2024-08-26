import 'package:chat_app_flutter/services/auth/auth_service.dart';
import 'package:chat_app_flutter/components/my_button.dart';
import 'package:chat_app_flutter/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    if(_passwordController.text == _confirmPasswordController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      }
      catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //password don't match
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            const Image(
              image: AssetImage('assets/chatLogo.webp'),
              height: 200,
            ),

            //welcomeback message
            Text(
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //email textfield
            MyTextField(
              controller: _emailController,
              hintText: "email",
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),

            //password textfield
            MyTextField(
              controller: _passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),

            //confirm password textfield
            MyTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),

            //login button
            MyButton(text: 'Register', onTap: () => register(context)),

            const SizedBox(height: 25),
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
