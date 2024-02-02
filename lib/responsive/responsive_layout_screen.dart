import 'package:flutter/material.dart';
import 'package:instagram_tutorial/providers/user_providers.dart';
import 'package:instagram_tutorial/responsive/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout
  })
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }
   addData() async{
    UserProvider _userProvider = Provider.of(context , listen: false);
    await _userProvider.refreshUser();
   }
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
     builder: ( context, constraints){
       if (constraints.maxWidth> webScreenSize ){
         //webscreen
         return widget.webScreenLayout;
       }
       //mobilescreen
       return widget.mobileScreenLayout;
        },
    );
  }
}
