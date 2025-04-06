import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    // Preload values here if needed
    _nameController.text = '';
    _emailController.text = '';
    _phoneController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(_isLocked ? Icons.lock : Icons.lock_open),
            onPressed: () {
              setState(() {
                _isLocked = !_isLocked;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildTextField("Name", Icons.person, _nameController, _isLocked),
              SizedBox(height: 16),
              buildTextField("Email", Icons.email, _emailController, _isLocked),
              SizedBox(height: 16),
              buildTextField("Phone", Icons.phone, _phoneController, _isLocked),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isLocked
                    ? null
                    : () {
                        setState(() {
                          _isLocked = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Profile Locked")),
                        );
                      },
                icon: Icon(Icons.check),
                label: Text("Lock & Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, IconData icon,
      TextEditingController controller, bool isLocked) {
    return TextField(
      controller: controller,
      enabled: !isLocked,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: isLocked ? Colors.grey[200] : Colors.white,
      ),
    );
  }
}
