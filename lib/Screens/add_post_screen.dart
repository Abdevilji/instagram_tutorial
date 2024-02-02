// import 'dart:typed_data';
//
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_tutorial/providers/user_providers.dart';
import 'package:instagram_tutorial/resources/firestore_methods.dart';
import 'package:instagram_tutorial/utils/colors.dart';
import 'package:instagram_tutorial/utils/utils.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_tutorial/providers/user_providers.dart';
// // import 'package:instagram_tutorial/resources/firestore_methods.dart';
// import 'package:instagram_tutorial/utils/colors.dart';
// import 'package:instagram_tutorial/utils/utils.dart';
// import 'package:provider/provider.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//   bool isLoading = false;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   _selectImage(BuildContext parentContext) async {
//     return showDialog(
//       context: parentContext,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Create a Post'),
//           children: <Widget>[
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a photo'),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   Uint8List file = await pickImage(ImageSource.camera);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose from Gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   void postImage(String uid, String username, String profImage) async {
//     setState(() {
//       isLoading = true;
//     });
//     // start the loading
//     // try {
//       // upload to storage and db
//       // String res = await FireStoreMethods().uploadPost(
//       //   _descriptionController.text,
//       //   _file!,
//       //   uid,
//       //   username,
//       //   profImage,
//       // );
//       // if (res == "success") {
//         setState(() {
//           isLoading = false;
//         });
//         if (context.mounted) {
//           showSnackBar(
//             context,
//             'Posted!',
//           );
//         }
//         clearImage();
//       } else {
//         if (context.mounted) {
//           showSnackBar(context, res);
//         }
//       }
//     } catch (err) {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(
//         context,
//         err.toString(),
//       );
//     }
//   }
//
//   void clearImage() {
//     setState(() {
//       _file = null;
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _descriptionController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//
//     return _file == null
//         ? Center(
//       child: IconButton(
//         icon: const Icon(
//           Icons.upload,
//         ),
//         onPressed: () => _selectImage(context),
//       ),
//     )
//         : Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: clearImage,
//         ),
//         title: const Text(
//           'Post to',
//         ),
//         centerTitle: false,
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => postImage(
//               userProvider.getUser.uid,
//               userProvider.getUser.username,
//               userProvider.getUser.photoUrl,
//             ),
//             child: const Text(
//               "Post",
//               style: TextStyle(
//                   color: Colors.blueAccent,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.0),
//             ),
//           )
//         ],
//       ),
//       // POST FORM
//       body: Column(
//         children: <Widget>[
//           isLoading
//               ? const LinearProgressIndicator()
//               : const Padding(padding: EdgeInsets.only(top: 0.0)),
//           const Divider(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   userProvider.getUser.photoUrl,
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.3,
//                 child: TextField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(
//                       hintText: "Write a caption...",
//                       border: InputBorder.none),
//                   maxLines: 8,
//                 ),
//               ),
//               SizedBox(
//                 height: 45.0,
//                 width: 45.0,
//                 child: AspectRatio(
//                   aspectRatio: 487 / 451,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.fill,
//                           alignment: FractionalOffset.topCenter,
//                           image: MemoryImage(_file!),
//                         )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
void clearImage(){
    setState(() {
      _file=null;
    });
}
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return _file == null
        ? Center(
            child: IconButton(
              icon: Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () => postImage(
                          userProvider.getUser.uid,
                          userProvider.getUser.username,
                          userProvider.getUser.photoUrl,
                        ),
                    child: const Text(
                      "post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProvider == Null
                          ? 'https://plus.unsplash.com/premium_photo-1669234305308-c2658f1fbf12?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                          : userProvider.getUser.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!)),
                        )),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}
