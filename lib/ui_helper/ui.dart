import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellowClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4647);
const Color white  = Color(0xffffffff);
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
    )
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle:TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      )
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      )
  );
}