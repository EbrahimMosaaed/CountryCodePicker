import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

final TextEditingController _phoneController = TextEditingController();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: [
        // Locale("ar"),
        Locale("en"),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('G2k Country Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 100,
                child: CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  isPassword: false,
                  textEditingController: _phoneController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  phoneTextFiled: CountryCodePicker(
                    onChanged: (e) {},
                    initialSelection: 'EG',
                    showCountryOnly: true,
                    showDropDownButton: true,
                    flagWidth: 35,
                    flagHeight: 35,
                    showOnlyCountryWhenClosed: false,
                    padding: EdgeInsets.zero,
                    searchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),

                      hintText: "Serach...",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.blue[50].withOpacity(0.3),
                      filled: true,
                      // icon: SizedBox(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              CountryCodePicker(
                onChanged: (e) {},
                initialSelection: 'EG',
                showCountryOnly: true,
                showDropDownButton: true,
                flagWidth: 35,
                flagHeight: 35,
                showOnlyCountryWhenClosed: false,
                padding: EdgeInsets.zero,
                searchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),

                  hintText: "Serach...",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.blue[50].withOpacity(0.3),
                  filled: true,
                  // icon: SizedBox(),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final Function onChanged;
  final Function onSaved;
  final Widget suffixIcon;
  final Widget phoneTextFiled;
  final String hintText;
  final int maxLengh;
  final TextEditingController textEditingController;
  final bool isPassword;

  bool hasError;
  String errorMsg;

  CustomTextFormField(
      {Key key,
      this.keyboardType,
      this.obscureText,
      this.onChanged,
      this.onSaved,
      this.hintText,
      this.maxLengh,
      this.textEditingController,
      this.suffixIcon,
      this.errorMsg,
      this.isPassword = false,
      this.hasError = false,
      this.phoneTextFiled})
      : super(key: key);

  ///*
  ///
  /// r'^[\u0621-\u064Aa-zA-Z]+$' 6 9
  /// remove numbers from name
  ///*/
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: (widget.keyboardType == TextInputType.phone ||
                  widget.keyboardType == TextInputType.number)
              ? TextDirection.ltr
              : Directionality.of(context),
          child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: TextFormField(
                      inputFormatters: [
                    // ignore: sdk_version_ui_as_code
                    if (widget.keyboardType == TextInputType.phone)
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    // ignore: sdk_version_ui_as_code
                    if (widget.keyboardType == TextInputType.name)
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[\u0621-\u064Aa-zA-Z ]+$')),
                    //please note that url mean passport till we make custom enum
                    // ignore: sdk_version_ui_as_code
                    if (widget.keyboardType == TextInputType.url)
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z0-9]+$')),
                    // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                      textInputAction: TextInputAction.done,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.isPassword && !isShowPassword,
                      controller: widget.textEditingController,
                      onChanged: widget.onChanged,
                      onSaved: widget.onSaved,
                      maxLines: 1,
                      maxLength: widget.maxLengh == null ? 40 : widget.maxLengh,
                      style: TextStyle(
                          fontFamily: (widget.keyboardType ==
                                      TextInputType.phone ||
                                  widget.keyboardType == TextInputType.number)
                              ? "Poppins"
                              : null,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      // textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: false,
                        counterText: "",
                        suffixIcon: widget.isPassword
                            ? InkWell(
                                onTap: () {
                                  isShowPassword = !isShowPassword;
                                  setState(() {});
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "show",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : widget.hasError
                                ? Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.info_rounded,
                                        color: Colors.red[900], size: 25),
                                  )
                                : widget.suffixIcon,
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 15, horizontal: 16),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        prefixIcon: widget.phoneTextFiled,

                        // prefixText: 'ss',
                        prefixIconConstraints:
                            BoxConstraints(minHeight: 15, minWidth: 15),
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )))),
        ),
        SizedBox(height: 5),
        // ignore: sdk_version_ui_as_code
        if (widget.hasError && widget.errorMsg != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text("${widget.errorMsg}",
                      style: TextStyle(color: Colors.red[900], fontSize: 12)),
                ),
              ],
            ),
          )
      ],
    );
  }
}
