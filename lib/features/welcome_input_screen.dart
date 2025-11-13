import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/utils/image_strings.dart';
import 'home/home_screen.dart';

class WelcomeInputScreen extends StatefulWidget {
  const WelcomeInputScreen({super.key});

  @override
  State<WelcomeInputScreen> createState() => _WelcomeInputScreenState();
}

class _WelcomeInputScreenState extends State<WelcomeInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _controller.text.trim().toUpperCase();
    final regex = RegExp(r'^[0-9]{6}[A-Z]$');
    setState(() {
      isButtonEnabled = regex.hasMatch(text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final indexNumber = _controller.text.trim().toUpperCase();

    if (indexNumber.length != 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter exactly 7 characters')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('index_number', indexNumber);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 56, bottom: 24, left: 24, right: 24),
          child: Column(
            children: [
              Image(height: 150, image: AssetImage(ImageStrings.appLogo)),
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "View current weather easily",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _controller,
                textCapitalization: TextCapitalization.characters,
                textAlign: TextAlign.center,
                maxLength: 7,
                decoration: InputDecoration(
                  labelText: "Enter Your Index Number",
                ),
                onChanged: (value) {
                  _controller.value = _controller.value.copyWith(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? _onSubmit : null,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
