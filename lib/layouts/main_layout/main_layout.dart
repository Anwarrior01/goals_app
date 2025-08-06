import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/layouts/main_layout/components/goal_item.dart';
import 'package:goals_app/layouts/main_layout/cubit/main_cubit.dart';
import 'package:goals_app/layouts/main_layout/cubit/main_states.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit()..initSql()..getData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Goals",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'Cairo',
              ),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: MainCubit.get(context).goalsList.length,
            itemBuilder: (context, index) => goalItem(
              MainCubit.get(context).goalsList[index]['id'],
              MainCubit.get(context).goalsList[index]['name'],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Container(
                    height: 240,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Add Goal",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Goal",
                            hintStyle: TextStyle(fontFamily: 'Cairo'),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
        
                            contentPadding: EdgeInsets.all(5),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.black,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  MainCubit.get(context).insertData('goal');
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.black,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  title: Text("Add Goal", style: TextStyle(fontFamily: 'Cairo')),
                ),
              );
            },
          ),
        );
  }
      ),
    );
  }
}
