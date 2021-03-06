import 'package:Beautech/global/package_export.dart';
import 'package:Beautech/global/widget_export.dart';
import 'package:Beautech/models/user.dart';
import 'package:Beautech/pages/account/widget/history_card.dart';
import 'package:Beautech/pages/account/widget/misc_card.dart';
import 'package:Beautech/pages/account/widget/profile_card.dart';
import 'package:Beautech/pages/account/widget/setting_card.dart';
import 'package:Beautech/services/firebase_services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: GlobalAppBar("Your Account",   action:  user == null ? [] :[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              child: Container(
                child: IconButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 22,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListView(
          children: [
            ProfileCard(),
            SizedBox(
              height: 6,
            ),
            History(),
            SizedBox(
              height: 6,
            ),
            SettingCard(),
            SizedBox(
              height: 6,
            ),
            MiscCard(),
            SizedBox(
              height: 6,
            )
          ],
        ),
      ),
    );
  }
}
