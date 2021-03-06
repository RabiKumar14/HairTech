

import 'package:Beautech/global/widget_export.dart';
import 'package:Beautech/pages/account/widget/faq.dart';
import 'package:Beautech/pages/account/widget/terms_and_condition.dart';
import 'package:flutter/material.dart';

class MiscCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
     child: Padding(
        padding: const EdgeInsets.all(15),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFont('Misc', Theme.of(context).primaryColor,
                fontSize: 16,      fontWeight: FontWeight.bold,),
            ListTile(
              leading: Icon(
                Icons.branding_watermark,
              ),
              title:
                  textFont('Terms & Conditions', Theme.of(context).accentColor, fontSize: 14),
              onTap: () {   Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>TermsAndConditions()),
              );},
            ),
            CustomDivider(),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle_sharp,
              ),
              title:
                  textFont('FAQ', Theme.of(context).accentColor, fontSize: 14),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>FAQ()),
              );}
            ),
          ],
        ),
      ),
    );
  }
}
