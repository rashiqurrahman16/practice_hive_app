import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
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
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _){
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].title.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                          Spacer(),
                          InkWell(
                              onTap: (){
                                  delete(data[index]);
                              },
                              child: Icon(Icons.delete, color: Colors.red,)),
                          SizedBox(width: 15,),
                          InkWell(
                              onTap: (){
                                _editDialog(data[index], data[index].title.toString(), data[index].description.toString());
                              },
                              child: Icon(Icons.edit)),
                        ],
                      ),
                      Text(data[index].description.toString())
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _showMyDialog();

          },
        child:  const Icon(Icons.add),
      ),
    );
  }



  void delete(NotesModel notesModel)async{
    await notesModel.delete();
  }

  Future<void> _editDialog(NotesModel notesModel, title, String description)async{

    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Edit Notes'),
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
                onPressed: ()async{

                  notesModel.title = titleController.text.toString();
                  notesModel.description = descriptionController.text.toString();

                  notesModel.save();

                  titleController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text('Edit'),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: Text('cancel')
              ),
            ],
          );
        }
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

                    // data.save(); // we are using listenable thats why it's not needed anymore
                    titleController.clear();
                    descriptionController.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Add'),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: Text('cancel')
              ),
            ],
          );
        }
    );
  }


}
