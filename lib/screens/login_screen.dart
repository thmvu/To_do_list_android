import 'package:du_an_todolist/const/color.dart';
import 'package:du_an_todolist/data/mock_users.dart';
import 'package:du_an_todolist/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  FocusNode emailFocusNode1 = FocusNode();
  FocusNode passwordFocusNode1 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    emailFocusNode1.addListener(() {
      setState(() {});
    });
    passwordFocusNode1.addListener(() {
      setState(() {});
    });
  }

  void _handleLogin() {
    final inputEmail = email.text.trim();
    final inputPassword = password.text.trim();

    if (inputEmail.isEmpty || inputPassword.isEmpty) {
      setState(() {
        _errorMessage = 'login_error_empty'.tr();
      });
      return;
    }

    final user = mockUsers.where(
      (u) => u.email == inputEmail && u.password == inputPassword,
    );

    if (user.isNotEmpty) {
      setState(() => _errorMessage = null);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(user: user.first)),
      );
    } else {
      setState(() {
        _errorMessage = 'login_error_wrong'.tr();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Nút chuyển ngôn ngữ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildLangButton('VI', const Locale('vi')),
                    const SizedBox(width: 6),
                    _buildLangButton('EN', const Locale('en')),
                  ],
                ),
              ),

              buildImage(),
              const SizedBox(height: 30),

              // Tiêu đề
              Text(
                'login_title'.tr(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'login_welcome'.tr(),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              textfield(email, emailFocusNode1, 'email'.tr()),
              const SizedBox(height: 16),
              passwordField(),
              const SizedBox(height: 10),

              // Thông báo lỗi
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),
              loginButton(),
              const SizedBox(height: 20),

              // Dòng "Không có tài khoản? Đăng ký"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_account'.tr(),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: điều hướng sang màn đăng ký
                      },
                      child: Text(
                        'register'.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Custom_green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLangButton(String label, Locale locale) {
    final isActive = context.locale == locale;
    return GestureDetector(
      onTap: () => context.setLocale(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Custom_green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Custom_green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            'login_button'.tr(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: password,
          focusNode: passwordFocusNode1,
          obscureText: _obscurePassword,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: passwordFocusNode1.hasFocus
                  ? Custom_green
                  : Colors.grey.shade300,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade400,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            hintText: 'password'.tr(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Custom_green, width: 2.0),
            ),
          ),
        ),
      ),
    );
  }

  Padding textfield(
    TextEditingController controller,
    FocusNode focusNode,
    String typeName,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: focusNode.hasFocus ? Custom_green : Colors.grey.shade300,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Custom_green, width: 2.0),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('imgs/anhbay.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailFocusNode1.dispose();
    passwordFocusNode1.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
