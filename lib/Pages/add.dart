
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_records/db_helper/database_connection.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  File? _selectedImage;
  final dbHelper=DatabaseHelper();
  final _userNameController=TextEditingController();
  final _userDomainController=TextEditingController();
  final _userContactController=TextEditingController();
 // bool _validate=false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Registrations',style: TextStyle(color: Colors.white),),
      ),

      body: SingleChildScrollView(
        child:Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                
                SizedBox(height: 20,),
                Text("Add student details"),
          
                SizedBox(height:50),
                Row(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: const Color.fromARGB(255, 18, 18, 18)),
                    //borderRadius: BorderRadius.circular(10)
                  ),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.fill,)
                      : Center(
                          child: Text(
                          'Add student photo',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ))),
            ),
            Column(children: [
              IconButton(
                  onPressed: () {
                    _pickImage();
                  },
                  icon: Icon(Icons.photo_library_outlined),tooltip: "select from gallery",),
              IconButton(
                  onPressed: () {
                    _photoImage();
                  },
                  icon: Icon(Icons.camera_alt_outlined),tooltip: "open camera")
            ])
          ]),
                SizedBox(height:50),
          
          
                    TextFormField(
          
                      validator: (value) {
                       if (value == null || value.isEmpty) {
                        
                         return 'Please enter your name';
                        }
                           return null;
                       },
          
                      controller: _userNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: UnderlineInputBorder(),
                        hintText: 'Full name',
                        
                      ),
                    ),
                    SizedBox(height: 50,),
          
                     TextFormField(
                       validator: (value) {
                       if (value == null || value.isEmpty) {
                        
                         return 'Please enter your domain';
                        }
                           return null;
                       },
                      controller: _userDomainController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.class_outlined),
                        border: UnderlineInputBorder(),
                        hintText: 'Domain'
                      ),
                    ),
          
                    SizedBox(height: 50,),
                    
                     TextFormField(
                       validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact';
                        } else if (value.length != 10) {
                          return 'Contact number must be 10 digits long';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Contact number can only contain numbers';
                        }
                        return null;
                      },
                       keyboardType: TextInputType.number,
                      controller: _userContactController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: UnderlineInputBorder(),
                        hintText: 'Contact'
                      ),
                    ),
          
                    SizedBox(height: 50,),
          
                    Row(children: [
                      IconButton(onPressed: (){
                        //_insertData(context);
                         if (_formKey.currentState!.validate()&&_selectedImage != null) {
                           _insertData(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
        
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form not complete')),
      );
    }
                      }, icon: Icon(Icons.save),color: Colors.green,tooltip:'SAVE',),
                      SizedBox(width: 20,),
                      IconButton(onPressed: (){
                        _userNameController.text="";
                          _userContactController.text="";
                         _userDomainController.text="";
                     }, icon: Icon(Icons.cancel_outlined),color:Colors.red,tooltip:'CLEAR',),
                      // TextButton(onPressed: (){}, child:Text("save"),),
                      
                    ],),
          
                    
              
          
              ],
            ),
          ),
        )
      )
      
    );
  }
  //insertion happening here start
void _insertData(BuildContext context) async {
    final name = _userNameController.text;
    final contact = int.tryParse(_userContactController.text) ?? 0;
    final domain = _userDomainController.text;

    if (name.isNotEmpty && contact > 0 && domain.isNotEmpty && _selectedImage != null) {
      final imageFileName ='student_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File('${(await getTemporaryDirectory()).path}/$imageFileName');
      await _selectedImage!
          .copy(imageFile.path); 

      final row = {
        'name': name,
        'domain': domain,
        'contact': contact,
        'imagePath': imageFile.path,
      };
      dbHelper.insert(row).then((id) {
        setState(() {
          _userNameController.clear();
          _userDomainController.clear();
          _userContactController.clear();
          _selectedImage = null;
        });
      });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Fill All Data, Including an Image'),
      //   behavior: SnackBarBehavior.floating,
      //   margin: EdgeInsets.all(10),
      //   duration: Duration(seconds: 2),
      // )
      // );
    }
  }

//insertion happening here end
Future<void> _photoImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}