import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educonecta/pages/home_page.dart';
import 'package:educonecta/pages/signin_page.dart';
import 'package:educonecta/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
        );

        Get.to(() => HomePage(userName: _nameController.text.trim()),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 1500));
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        if (e.code == 'weak-password') {
          errorMessage = 'A senha deve conter pelo menos 6 caracteres.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Este e-mail já está em uso.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'O endereço de e-mail não é válido.';
        } else {
          errorMessage = 'Erro desconhecido: ${e.message}';
        }

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/logo2.png')),
                      TextFieldForm(
                        hintText: 'Full name',
                        suffixIcon: Icon(Icons.person),
                        obscureText: false,
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldForm(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email),
                        obscureText: false,
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldForm(
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: _isLoading ? null : () => _registerUser(context),   
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize: const Size(380, 68)),
                        child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?')),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Container(
                              height: 2.0,
                              width: 130,
                              color: Colors.grey,
                            ),
                          ),
                          const Text('OR'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Container(
                              height: 2.0,
                              width: 130,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: const Size(380, 68)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                            ),
                            Text(
                              'Log in with Facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(380, 68)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.people),
                              Text(
                                'Log in with Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already an account yet?",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(SignInPage(),
                                    transition: Transition.fade,
                                    duration:
                                        const Duration(milliseconds: 1000));
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }
}
