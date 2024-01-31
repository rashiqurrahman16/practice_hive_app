import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practice_hive_app/models/notes_model.dart';

import 'boxes/boxes.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [


        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _showMyDialog();

          },
        child:  const Icon(Icons.add),
      ),
    );
  }


  Future<void> _showMyDialog()async{

    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter Description',
                        border: OutlineInputBorder()
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text
                    );

                    final box = Boxes.getData();
                    box.add(data);
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('cancel')
              ),
            ],
          );
        }
    );
  }


}
