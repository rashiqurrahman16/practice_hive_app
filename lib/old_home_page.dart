import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          FutureBuilder(
            future: Hive.openBox('oyon'),
            builder: (context, snapshot){
              return Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data!.get('name').toString()),
                    subtitle: Text(snapshot.data!.get('age').toString()),
                  ),
                  Text(snapshot.data!.get('name').toString()),
                  Text(snapshot.data!.get('age').toString()),
                  Text(snapshot.data!.get('details').toString()),
                ],
              );
            },
          ),
          FutureBuilder(
            future: Hive.openBox('name'),
            builder: (context, snapshot){
              return Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data!.get('abc').toString()),
                    trailing: IconButton(
                      onPressed: (){
                        snapshot.data!.put('abc', 'Rashiqur r');   //if i press the edit button then previous name will be edited with this one
                        setState(() {

                        });
                      }, icon: Icon(Icons.edit),
                    ),

                  ),
                ],
              );
            },
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('oyon');
          var box2 = await Hive.openBox('name');


          box2.put('abc', 'Rashiqur Rahman');
          box.put('name', 'RR oyon');
          box.put('age', '23');

          box.put('details', {
            'pro' : 'developer',
            'a' : 'aaaa'
          });

          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details'));
          print(box.get('details')['pro']);

        },
        child:  const Icon(Icons.add),
      ),
    );
  }
}
