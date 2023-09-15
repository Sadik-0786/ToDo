import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/ui_helper/ui.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget ?widget;
  final TextEditingController?controller;
  const MyInputField({super.key,
  required this.title,
    required this.hint,
  this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child:TextField(
                  readOnly: widget==null?false:true,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                         width:0
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width:0
                        )
                    )
                  ),
                  autofocus: false,
                  cursorColor: Colors.grey.shade700,
                  controller: controller,
                  style: subTitleStyle,

                )),
                widget==null?Container():Container(child: widget,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
