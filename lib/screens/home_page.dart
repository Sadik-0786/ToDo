import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/cubit_state_managment/list_cubit.dart';
import 'package:to_do_app/cubit_state_managment/list_state.dart';
import 'package:to_do_app/screens/add_task.dart';
import 'package:to_do_app/ui_helper/ui.dart';
import 'package:to_do_app/ui_helper/widget/list_tile.dart';

import '../models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate = DateTime.now();
  List<Task> tasks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     context.read<ListCubit>().initialData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar(),
      body:Column(
        children: [
       _addTaskBar(),
          _addDateBar(),
         _showTasks(),
      ],),
    );
  }
  _showTasks(){
    return Expanded(child: BlocBuilder<ListCubit,ListState>(
      builder: (ctx,state){
        tasks=state.arrData;
        return ListView.builder(
          itemCount: tasks.length,
            itemBuilder: (context,index){
            if(tasks[index].repeat=='Daily'){
              return AnimationConfiguration.staggeredList(
                  position:index,
                  child:SlideAnimation(
                    child:FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(20),
                                        topRight:Radius.circular(20), )
                                  ),
                                  builder:((contax){
                                    return Container(
                                      padding: const EdgeInsets.only( top:10),
                                      height: tasks[index].isCompleted==1?
                                      MediaQuery.of(context).size.height*0.24:
                                      MediaQuery.of(context).size.height*0.32,
                                      decoration:const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(20),
                                          topRight:Radius.circular(20),),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 6,
                                            width: 120,
                                            decoration:BoxDecoration (
                                                borderRadius: BorderRadius.circular(3),
                                                color: Colors.grey.shade300
                                            ),
                                          ),
                                          const Spacer(),
                                          tasks[index].isCompleted==1?Container():
                                          _mBottomButton(buttonName: 'Task Completed',
                                              onTap: () async {
                                                await BlocProvider.of<ListCubit>(context).markTaskCompleted(tasks[index]);
                                                Navigator.pop(context);},clr:bluishClr),
                                          gap(hight: 10),
                                          _mBottomButton(buttonName: 'Delet Task',
                                              onTap: () async {
                                                await BlocProvider.of<ListCubit>(context).removeData(tasks[index]);
                                                Navigator.pop(context);},clr:Colors.redAccent),
                                          const Spacer(),
                                          _mBottomButton(buttonName: 'Close',
                                              onTap: (){Navigator.pop(context);},clr:Colors.white,isClose: true),
                                          gap(hight: 10),
                                        ],
                                      ),
                                    );
                                  })
                              );
                              //BlocProvider.of<ListCubit>(context).removeData(tasks[index]);
                            },
                            child: TaskTile(tasks[index]),
                          )
                        ],
                      ),
                    ) ,
                  )
              );
            }
            if(tasks[index].date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                  position:index,
                  child:SlideAnimation(
                    child:FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(20),
                                        topRight:Radius.circular(20), )
                                  ),
                                  builder:((contax){
                                    return Container(
                                      padding: const EdgeInsets.only( top:10),
                                      height: tasks[index].isCompleted==1?
                                      MediaQuery.of(context).size.height*0.24:
                                      MediaQuery.of(context).size.height*0.32,
                                      decoration:const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(20),
                                          topRight:Radius.circular(20),),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 6,
                                            width: 120,
                                            decoration:BoxDecoration (
                                                borderRadius: BorderRadius.circular(3),
                                                color: Colors.grey.shade300
                                            ),
                                          ),
                                          const Spacer(),
                                          tasks[index].isCompleted==1?Container():
                                          _mBottomButton(buttonName: 'Task Completed',
                                              onTap: () async {
                                                await BlocProvider.of<ListCubit>(context).markTaskCompleted(tasks[index]);
                                                Navigator.pop(context);},clr:bluishClr),
                                          gap(hight: 10),
                                          _mBottomButton(buttonName: 'Delet Task',
                                              onTap: () async {
                                                await BlocProvider.of<ListCubit>(context).removeData(tasks[index]);
                                                Navigator.pop(context);},clr:Colors.redAccent),
                                          const Spacer(),
                                          _mBottomButton(buttonName: 'Close',
                                              onTap: (){Navigator.pop(context);},clr:Colors.white,isClose: true),
                                          gap(hight: 10),
                                        ],
                                      ),
                                    );
                                  })
                              );
                              //BlocProvider.of<ListCubit>(context).removeData(tasks[index]);
                            },
                            child: TaskTile(tasks[index]),
                          )
                        ],
                      ),
                    ) ,
                  )
              );
            }else{
              return Container();
            }
        }
        );
      },
    ));
  }
  _mBottomButton({required String buttonName,required  Function() onTap,required Color clr,bool isClose=false }){
    return  ElevatedButton(
    onPressed:onTap,
style:ElevatedButton.styleFrom(
backgroundColor:isClose==true?Colors.white:clr,
minimumSize:Size(MediaQuery.of(context).size.width*0.9,55),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
  side: BorderSide( color: isClose==true?Colors.grey.shade300:clr)
)
) ,
child:Text(buttonName,style: isClose?titleStyle.copyWith(color: Colors.black):titleStyle.copyWith(color: Colors.white)) );
  }
  _addTaskBar(){
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),style:subHeadingStyle,),
              gap(hight: 5),
              Text('Today',style: headingStyle,),
            ],
          ),
          ElevatedButton(
              onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const AddTaskPage()));
          },
              style:ElevatedButton.styleFrom(
                  backgroundColor: bluishClr,
                  minimumSize:const Size(100,60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ) ,
              child:const Text('+Add Task') )
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text('ToDo',style: TextStyle(color:Colors.black,fontSize: 20),),
            ],
          ),
        ],
      ),
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

  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 90,
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });
        },
        initialSelectedDate: DateTime.now(),
        selectionColor: bluishClr,
        selectedTextColor: white,
        dateTextStyle:GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),

        ),
      ),
    );
  }

}


gap({double?width, double?hight}){
  return SizedBox(
    height: hight,
    width: width,
  );
}