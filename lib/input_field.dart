import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class HmtInputField extends StatelessWidget {
  // Properties properties;
  TextInputType _textInput;
  String _title;
  dynamic _formDataModel;
  String _name;
  HmtInputField(this._textInput, this._title, this._formDataModel, this._name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: TextFormField(
          keyboardType: _textInput,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _title,
          ),
          onSaved: (dynamic value) {_formDataModel[_name] = value;},
        ),
      )
    );
  }
}