import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educonecta/pages/home_page.dart';
import 'package:educonecta/pages/signup_page.dart';
import 'package:educonecta/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

// ignore: unused_element
  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Inicia o processo de autenticação com Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Login cancelado pelo usuário
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Cria credenciais para o Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase com as credenciais do Google
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Busca os dados no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String userName = userDoc['name'];

        Get.to(() => HomePage(userName: userName),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 1500));
      } else {
        // Se o usuário não existe no Firestore, crie o registro
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': userCredential.user!.displayName ?? 'Usuário do Google',
          'email': userCredential.user!.email,
          'createdAt': DateTime.now(),
        });

        Get.to(() => HomePage(userName: userCredential.user!.displayName ?? ''),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 1500));
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login com Google: ${e.message}')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro desconhecido: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loginUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          String userName = userDoc['name'];

          Get.to(() => HomePage(userName: userName),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 1500));
        } else {
          throw Exception('Usuário não encontrado no Firestore.');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'Email não cadastrado.';
            break;
          case 'wrong-password':
            errorMessage = 'Senha incorreta. Tente novamente.';
            break;
          default:
            errorMessage = 'Erro: ${e.message}';
        }

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro desconhecido: ${e.toString()}'),
          ),
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
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 14),
                      suffixIcon: Icon(Icons.email),
                      obscureText: false,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 24),
                    TextFieldForm(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 14),
                        suffixIcon: Icon(Icons.visibility_off),
                        obscureText: true,
                        controller: _passwordController),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : () => _loginUser(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(356, 62)),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 1.0,
                              width: 128,
                              color: Colors.grey,
                            ),
                          ),
                          const Text('OR'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 1.0,
                              width: 128,
                              color: Colors.grey,
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
                          backgroundColor: Colors.blueAccent[400],
                          fixedSize: const Size(356, 62)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/facebook.png',
                            fit: BoxFit.cover,
                            width: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: const Text(
                              'Log in with Facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _loginWithGoogle(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: const Size(356, 62)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              fit: BoxFit.cover,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: const Text(
                                'Log in with Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(SignUpPage(),
                                  transition: Transition.fade,
                                  duration: const Duration(milliseconds: 1500));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 14),
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
      ),
    );
  }
}
