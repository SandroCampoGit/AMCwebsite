import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  String fullName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
  String raceNumber = '';

  bool isUpdatingUser = false;
  String updatedEmail = '';
  String updatedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'User Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: $email'),
            Text('Password: $password'),
            const SizedBox(height: 16),
            const Text(
              'Update User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (!isUpdatingUser)
              TextButton(
                child: const Text('Update Email & Password'),
                onPressed: () {
                  setState(() {
                    isUpdatingUser = true;
                  });
                },
              ),
            if (isUpdatingUser)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Update Email & Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Updated Email'),
                    onChanged: (value) {
                      setState(() {
                        updatedEmail = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Updated Password'),
                    onChanged: (value) {
                      setState(() {
                        updatedPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    child: const Text('Save Changes'),
                    onPressed: () {
                      setState(() {
                        email = updatedEmail;
                        password = updatedPassword;
                        isUpdatingUser = false;
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AccountsPage(),
  ));
}
