import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/cubit_state_managment/list_cubit.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screens/home_page.dart';
import 'package:to_do_app/ui_helper/ui.dart';

import '../ui_helper/widget/inputfeild.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController= TextEditingController();
  final  TextEditingController _notesController= TextEditingController();
  DateTime _selectedDate=DateTime.now();
  String _endtTime ='9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind=5;
  List<int> remindList=[5,10,15,20];
  String _selectedRepeat='None';
  List<String> repeatList=['None','Daily','Weekly','Monthly'];
  List<Color> listOfColor=[bluishClr,pinkClr,yellowClr];
    int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task',style: headingStyle,),
              MyInputField(title:"Title", hint: 'Enter your title',controller: _titleController,),
              MyInputField(title:"Notes", hint: 'Enter your notes',controller: _notesController,),
              MyInputField(title:"Date", hint: DateFormat.yMd().format(_selectedDate),widget:IconButton(onPressed: (){_getDateFromUser();},icon: Icon(Icons.calendar_month,color: Colors.grey),) ,),
              Row(
                children: [
                  Expanded(child: MyInputField(title: 'Start Time',hint:_startTime ,widget: IconButton(onPressed: (){_getTimeFromUser(isStarTime: true);},icon: Icon(Icons.access_time_rounded,color: Colors.grey,),),)),
                  gap(width: 20),
                  Expanded(child: MyInputField(title: 'End Time',hint:_endtTime ,widget: IconButton(onPressed: (){_getTimeFromUser(isStarTime: false);},icon: Icon(Icons.access_time_rounded,color: Colors.grey,),),))
                ],
              ),
              MyInputField(title: 'Remind' ,hint:'$_selectedRemind minutes early',
                widget: DropdownButton(
                    items: remindList.map<DropdownMenuItem<String>>(
                            (int intValue) {
                              return DropdownMenuItem<String>(
                                  value: intValue.toString(),
                                  child: Text(intValue.toString(),style:TextStyle(color: Colors.black) ,),
                              );
                                      }
                             ).toList(),
                  icon: Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                  iconSize:32,style:subTitleStyle,
                  onChanged: (String? value) {setState(() {
                    _selectedRemind=int.parse(value!) ;
                  });},
                ),
              ),
              MyInputField(title: 'Repeat' ,hint:_selectedRepeat,
                widget: DropdownButton(
                  items: repeatList.map<DropdownMenuItem<String>>(
                          (String stringValue) {
                        return DropdownMenuItem<String>(
                          value: stringValue,
                          child: Text(stringValue,style:TextStyle(color: Colors.black),),
                        );
                      }
                  ).toList(),
                  underline: Container(height: 0,),
                  icon: Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                  iconSize:32,style:subTitleStyle,
                  onChanged: (String? value) {setState(() {
                    _selectedRepeat= value!;
                  });},
                ),
              ),
              gap(hight:20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 _colorpallete(),
                  ElevatedButton(
                      onPressed: (){
                   _validateData();

                  },
                      style:ElevatedButton.styleFrom(
                          backgroundColor: bluishClr,
                          minimumSize:Size(100,60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ) ,
                      child:Text('Create Task') )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _validateData(){
    if(_titleController.text.isNotEmpty&&_notesController.text.isNotEmpty)
      {
        _addTaskToDb();
        Navigator.pop(context);
      }
    else if(_titleController.text.isEmpty||_notesController.text.isEmpty){
      print('enter all values');
    }
  }
  _colorpallete(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color',style: titleStyle,),
        gap(hight: 5
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (index){
                return GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex=index;
                    });
                  } ,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor:listOfColor[index] ,
                      child: selectedIndex==index?Icon(Icons.done,color: Colors.white,size: 16,):Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
  _addTaskToDb(){
    BlocProvider.of<ListCubit>(context).addData(
        task:Task(
            note: _notesController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endtTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: selectedIndex,
            isCompleted: 0
        )
    );
  }
  _appBar(){
    return AppBar(
      leading: Center(child: InkWell( onTap: (){
        Navigator.pop(context);
      },child: Icon(Icons.arrow_back_ios,color:bluishClr,)),),
      backgroundColor: Colors.white,
      elevation:0 ,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              right: 10
          ),
          child: CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            maxRadius: 20,
            minRadius: 20,
            child: Image.asset("assets/image/bat.png",fit: BoxFit.fill,),
          ),
        )
      ],
    );
  }
  _getDateFromUser() async{
    DateTime? _datePicker=  await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:DateTime(2223)
    );
    if(_datePicker!=null){
      setState(() {
        _selectedDate=_datePicker;
      });
    }else{
      print('something went wrong');
    }
  }
  _getTimeFromUser({required bool isStarTime}) async{
    var timePicker= await _showTimePicker();
    String stringTimePicker= timePicker.format(context);
    if(timePicker!=null) {
      if (isStarTime == true) {
        setState(() {
         _startTime = stringTimePicker;
        });
      }
      else {
        setState(() {
          _endtTime = stringTimePicker;
        });
      }
    }
  }
  _showTimePicker() async{
    return await  showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        )
    );
  }
}
