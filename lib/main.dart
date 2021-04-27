import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/input_field.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My First App'),
          centerTitle: true,
          backgroundColor: Colors.redAccent
      ),
      body: Center(
        child: CustomForm(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Click'),
        onPressed: () {

        },
      ),
    );
  }
}

// Define a custom Form widget.
class CustomForm extends StatefulWidget {
  @override
  CustomerFormState createState() {
    return CustomerFormState();
  }
}

class Schema {
  String? type;
  List<String>? required;
  Map<String, Property>? properties;
}

class Property {
  String name;
  String type;
  String title;

  Property(this.name, this.title, this.type);

  Property.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        title = json['title'],
        type = json["type"];
}

class CustomerFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _jsonMap = new Map();
  List<Widget> _widgetList = [];
  dynamic _dataModel = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await loadJson();
      _widgetList = getChildWidgets();
    });
  }

  loadJson() async {
    String data = await rootBundle.loadString('assets/jsons/a.json');
    this._jsonMap = json.decode(data);
  }

  List<Widget> getChildWidgets() {
    Map<String, dynamic> properties = _jsonMap["properties"];
    // List<String> requiredFields = _jsonMap["required"];
    List<Widget> widgets = [];
    properties.forEach((key, value) {
      Property property = Property.fromJson(value);
      widgets.add(
        getRelevantWidget(property, _dataModel)
      );
      print(key);
    });
    return widgets;
  }

  Widget getRelevantWidget(Property property, dynamic dataModel) {
    switch(property.type) {
      case 'number':
        return HmtInputField(TextInputType.number, property.title, dataModel, property.name);
      case 'text':
        return HmtInputField(TextInputType.text, property.title, dataModel, property.name);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build complete');
    return Form(
      key: _formKey,
      child: Column(
        children: _widgetList,
      ),
      onChanged: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
        print(_dataModel);
      },

    );
  }
}




class JsonSchemaFormBuilder extends StatefulWidget {
  @override
  JSONSchemaFormState createState() {
    return new JSONSchemaFormState();
  }
  
}

class JSONSchemaFormState extends State<JsonSchemaFormBuilder> {

  void getTestSchema() async {
    String content = await rootBundle.loadString('assets/a.json');
    Map<String, dynamic> jsonMap = json.decode(content);
    // _jsonSchema.add(Schema.fromJson(jsonMap));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}