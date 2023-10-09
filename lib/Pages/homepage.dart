import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/Pages/DetailsPage.dart';
import 'package:student_records/Pages/add.dart';
import 'package:student_records/db_helper/database_connection.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
   const Homepage ({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final searchController=TextEditingController();
  final dbhelper=DatabaseHelper();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userDomainController = TextEditingController();
  final TextEditingController _userContactController = TextEditingController();
 
  File? _selectedImage;//to hold selected image

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shape:RoundedRectangleBorder(borderRadius:BorderRadius.vertical(bottom: Radius.circular(35)) ) ,
        elevation:8,shadowColor: Color.fromARGB(255, 0, 0, 0),
        //toolbarHeight: 50,

        backgroundColor: Colors.teal,

        //search icon
        leading:IconButton(onPressed: (){}, icon: Icon(Icons.home),color: Colors.white,),
        title:Text('STUDENT REGISTER',style:GoogleFonts.orbitron(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white)),
        centerTitle: true,
        actions: [

          //refresh icon
          IconButton(onPressed: (){
            setState(() {
              
            });
          }, 
          icon: Icon(Icons.refresh),color:const Color.fromARGB(255, 251, 251, 251),),
          //IconButton(onPressed: (){}, icon: Icon(Icons.refresh),color:Colors.black,)
        ],
      ),
      

      //floating action button 
      floatingActionButton:FloatingActionButton(
       
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPage()));
        },
        mini: true,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add,color: Colors.white,),      
      ),

      body: Column(
          children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: TextField(
                  controller: searchController,
                  
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'search name ', 
                    //label: Text("search")
                  ),
                  onChanged: (valu) {
                    setState(() {
                      
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String ,dynamic>>>(
              future: dbhelper.searchAll(searchController.text),
             
            builder: (context, snapshot) {
              // if(!snapshot.hasData){
              //   return CircularProgressIndicator();
              // }
              final data=snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showtData(data[index], context);
                    },
                    leading:CircleAvatar(backgroundImage: FileImage(File(data[index]['imagePath']))
                    ),
                    title: Text(data[index]['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            //  edit action
                          _editData(data[index],context);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: () {
                            //  delete action
                            _showDeleteDialog(data[index]['id'], context);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            },),
          )
        ],
      )
    );
  }

  void _showDeleteDialog(int id, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Data'),
          content: Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteData(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteData(int id) {
    dbhelper.delete(id).then((rowsDeleted) {
      if (rowsDeleted > 0) {
        setState(() {
          // Reload data after deletion
        });
      }
    });
  }



  void _editData(Map<String, dynamic> data, BuildContext context) {
    _userNameController.text = data['name'];
    _userContactController.text = data['contact'].toString();
    _userDomainController.text = data['domain'];
    _selectedImage = File(data['imagePath']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _userContactController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: _userDomainController,
                  decoration: InputDecoration(labelText: 'Domain'),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.deepOrange),
                        ),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover)),
                  ),
                  Column(children: [
                    IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(Icons.photo)),
                    IconButton(
                        onPressed: () {
                          _photoImage();
                        },
                        icon: Icon(Icons.camera))
                  ])
                ]),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                updateData(data['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  


void updateData(int id) {
    final name = _userNameController.text;
    final contact = int.tryParse(_userContactController.text) ?? 0;
    final domain = _userDomainController.text;
    final imagePath = _selectedImage!.path;

    if (name.isNotEmpty && contact>0 && domain.isNotEmpty) {
      final row = {
        'id': id,
        'name': name,
        'contact': contact,
        'domain': domain,
        'imagePath': imagePath
      };
      dbhelper.update(row).then((rowsUpdated) {
        if (rowsUpdated > 0) {
          setState(() {
            _userNameController.clear();
            _userContactController.clear();
            _userDomainController.clear();
          });
        }
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

  Future<void> _photoImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void showtData(Map<String, dynamic> data, BuildContext context) {
    var name = data['name'];
    var contact = data['contact'];
    var domain = data['domain'];
    var imagePath = data['imagePath'];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          name: name,
          domain: domain,
          contact: contact,
          imagePath: imagePath,
        ),
      ),
    );
  }
  }