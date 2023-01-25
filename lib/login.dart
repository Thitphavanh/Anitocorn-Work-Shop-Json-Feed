import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'models/user.dart';
import 'services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  AuthService authService = AuthService();
  FocusNode passwordFocusNode = FocusNode();
  bool statusRedEye = true;
  Color colorBlack = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background17.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              children: [
                _buildForm(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card _buildForm() => Card(
        margin: const EdgeInsets.only(
          top: 80.0,
          left: 20.0,
          right: 20.0,
        ),
        color: Colors.white38,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _logo(),
                const SizedBox(height: 22.0),
                _buildUsernameInput(),
                const SizedBox(height: 8.0),
                _buildPasswordInput(),
                const SizedBox(height: 28.0),
                _buildSubmitButton(),
                _buildForgotPasswordButton(),
              ],
            ),
          ),
        ),
      );

  Image _logo() => Image.asset(
        "assets/phenomenal.jpg",
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );

  TextFormField _buildUsernameInput() => TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "email",
          labelStyle: TextStyle(color: colorBlack),
          hintStyle: const TextStyle(color: Colors.black38),
          icon: Icon(
            Icons.email,
            color: colorBlack,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: _validateEmail,
        onSaved: (String? value) {
          user.username = value;
        },
        onFieldSubmitted: (String? value) {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
      );

  TextFormField _buildPasswordInput() => TextFormField(
        focusNode: passwordFocusNode,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
            },
            icon: statusRedEye
                ? Icon(Icons.remove_red_eye, color: colorBlack)
                : Icon(Icons.remove_red_eye_outlined, color: colorBlack),
          ),
          labelText: "Password",
          hintText: "password",
          labelStyle: TextStyle(color: colorBlack),
          hintStyle: const TextStyle(color: Colors.black38),
          icon: Icon(
            Icons.password,
            color: colorBlack,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: statusRedEye,
        validator: _validatePassword,
        onSaved: (String? value) {
          user.password = value;
        },
        onFieldSubmitted: (String? value) {},
      );

  SizedBox _buildSubmitButton() => SizedBox(
        // color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: colorBlack),
          onPressed: _submit,
          child: const Text("LOGIN"),
        ),
      );

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      authService.login(user: user).then((result) {
        if (result) {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        } else {
          _showAlertDialog();
        }
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Please Try Again."),
          content: const Text("Username or Password is incorrect."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(color: colorBlack),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return "The Email is Empty";
    }
    if (!isEmail(value)) {
      return "The Email must be a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.length < 8) {
      return "The Password must be at least 8 charactors";
    }
    return null;
  }

  TextButton _buildForgotPasswordButton() => TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot password?",
          style: TextStyle(color: Colors.black45),
        ),
      );
}
