import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State {
// TODO : 1. Deklarasi Variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  String _errorText = '';
  bool _obscurePassword = true;

//TODO: 1. Membuat metode Sign Up
  void _signUp() async {
    String name = _fullnameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (password.length < 8 ||
    !password.contains(RegExp(r'[A-Z]')) ||
    !password.contains(RegExp(r'[a-z]')) ||
    !password.contains(RegExp(r'[0-9]')) ||
    !password.contains(RegExp(r'[!@#$%^&*():{}<>]'))) {
      setState(() {
        _errorText = 'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\\\$%^&*():{}<>]';
      });
      return;
    };

    print('*** Sign Up berhasil!');
    print('fullname: $name');
    print('username: $username');
    print('pasword: $password');
  }

// TODO: 2. Membuat metode dispose
  @override
  void dispose(){
// TODO: Implementasi dispose
    _fullnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// TODO : 2. Pasang Appbar
      appBar: AppBar(title: Text('Sign Up'),),
// TODO : 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
// TODO : 4. Atur mainAxisAligment dan CrossAxisAligment
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(),
                  ),
                ),
// TODO : 5. Pasang TextFormField Nama Pengguna
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Nama Pengguna",
                    border: OutlineInputBorder(),
                  ),
                ),
// TODO : 6. Pasang TextFormField Kata Sandi
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState((){
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
// TODO : 7. Pasang ElevatedButton Sign In
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
// if(_passwordController.value.text.length < 8){
// _errorText = "Password harus lebih dari atau sama dengan 8 karakter";
// } else if(!_passwordController.value.text.contains(RegExp(r'[A-z'))){
// _errorText = 'Password harus berisi uppercase';
// }else if(!_passwordController.value.text.contains(RegExp(r'[a-z]'))){
// _errorText = 'Password harus berisi lowercase';
// }else if(!_passwordController.value.text.contains(RegExp(r'[0-9]'))){
// _errorText = 'Password harus berisi angka';
// }else if(!_passwordController.value.text.contains(RegExp(r'[/*.,]'))){
// _errorText = 'Password harus berisi karakter spesial (/*.,)';
// }else if(
// _passwordController.value.text.contains(_fullnameController.value.text) ||
// _passwordController.value.text.contains(_usernameController.value.text)
// ){
// _errorText = 'Password harus berisi nama atau nama pengguna anda';
// } else {
// _errorText = '';
// }
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Sign In')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}