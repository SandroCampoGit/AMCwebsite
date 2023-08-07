import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  String password = ''; 
  
  bool isUpdatingUser = false;
  String updatedEmail = '';
  String updatedPassword = '';

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // This will close the current screen. Depending on your app's structure, you might want to navigate to a different screen instead.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
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
            Text('Email: ${user?.email ?? "N/A"}'),
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
                    onPressed: () async {
                      if (user != null) {
                        if (updatedEmail.isNotEmpty) {
                          await user!.updateEmail(updatedEmail);
                        }
                        if (updatedPassword.isNotEmpty) {
                          await user!.updatePassword(updatedPassword);
                        }
                        setState(() {
                          isUpdatingUser = false;
                        });
                      }
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
