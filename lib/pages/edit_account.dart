import 'package:flutter/material.dart';
import 'package:hair_salon/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.bgColour,
        iconTheme: IconThemeData(color: LightTheme.mainColour),
        centerTitle: true,
        title: Text(
          'Edit Account',
          style: GoogleFonts.varelaRound(
            color: LightTheme.mainColour,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              shadowColor: Colors.grey[300],
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[200],
                      Colors.white,
                    ],
                    stops: [0.1, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.email,
                      ),
                      title: Text("Change Email"),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline,
                      ),
                      title: Text("Change Password"),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                      ),
                      title: Text("Change Phone Number"),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                      ),
                      title: Text("Change Address"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}