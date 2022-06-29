import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

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
              SizedBox(
                // width: 400,
                // height: 400,
                child: CountryCodePicker(
                  onChanged: (e) {
                    print('TTTTTEEESSSSTTT ' + e.dialCode);
                  },
                  initialSelection: 'EG',
                  showCountryOnly: true,
                  showDropDownButton: true,

                  showOnlyCountryWhenClosed: false,
                  // dialogSize: Size(double.infinity, 600),
                  padding: EdgeInsets.zero,
                  searchDecoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(horizontal: 20,v),
                      prefixIconConstraints: BoxConstraints(
                          minWidth: 10, maxWidth: 20, maxHeight: 0),
                      hintText: "Serach...",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: SizedBox(),
                      suffixIcon: SizedBox(),
                      fillColor: Colors.blue[50].withOpacity(0.3),
                      filled: true,
                      icon: SizedBox(),
                      border: InputBorder.none),
                  // favorite: ['+39', 'FR'],
                ),
              ),

              CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'IT',
                favorite: ['+39', 'FR'],
                countryFilter: ['IT', 'FR'],
                // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                flagDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'IT',
                favorite: ['+39', 'FR'],
                countryFilter: ['IT', 'FR'],
                showFlagDialog: false,
                comparator: (a, b) => b.name.compareTo(a.name),
                //Get the country information relevant to the initial selection
                onInit: (code) =>
                    print("on init ${code.name} ${code.dialCode} ${code.name}"),
              ),
              // SizedBox(
              //   width: 400,
              //   height: 60,
              //   child: CountryCodePicker(
              //     onChanged: print,
              //     hideMainText: true,
              //     showFlagMain: true,
              //     showFlag: false,
              //     initialSelection: 'TF',
              //     hideSearch: true,
              //     showCountryOnly: true,
              //     showOnlyCountryWhenClosed: true,
              //     alignLeft: true,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
