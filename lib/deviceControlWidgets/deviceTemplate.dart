import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_control/communication/communication.dart';
import 'package:string_validator/string_validator.dart';

import '../MainTabWidget.dart';

const List<String> devices = [
  "Simple Switch",
];

// DeviceControl Widget Base for all Devices to control
abstract class DeviceControl extends StatefulWidget {
  DeviceControl({Key key, @required this.name, @required this.hostname, @required this.page, @required this.deviceNAME}) : super(key: key);

  final String deviceNAME;

  final int page;
  final String name;
  final String hostname;

  void saveToDataBase();
}

// DeviceControlState Widget Base for all Devices to control
abstract class DeviceControlState<T extends DeviceControl> extends State<T> {

  Timer poller;
  CommunicationHandler server;

  void setupCommunicationHandler();
  void pollDeviceStatus();

  void startTimer(int sec){
    if (poller != null) {
      poller.cancel();
    }
    poller = Timer.periodic(Duration(seconds: sec), (Timer t) {
      pollDeviceStatus();
    });
  }

  @override
  void initState() {
    super.initState();
    setupCommunicationHandler();
    Timer.run(() { pollDeviceStatus(); });
    startTimer(2);
  }

  @override
  void dispose(){
    poller.cancel();
    super.dispose();
  }
}

// DeviceConfig Widget Base for add/setup DeviceControl to List
abstract class DeviceConfig extends StatefulWidget {
  DeviceConfig({Key key, @required this.page}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController hostname = TextEditingController();

  final int page;

  void clearFields();

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please enter a name";
    }
    return null;
  }

  String validateHostname(String value) {
    RegExp hostname = RegExp(r'^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$');

    if (value.isEmpty) {
      return "Please enter a hostname";
    }
    if (!hostname.hasMatch(value)) {
      if (!isIP(value)){
        return "Please enter a valid IP or hostname";
      }
      return null;
    }
    return null;
  }
}