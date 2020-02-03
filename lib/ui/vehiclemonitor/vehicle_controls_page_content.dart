import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobileclient/rotor_utils.dart';
import 'package:mobileclient/data/rotor_command.dart';
import 'package:mobileclient/ui/commonwidgets/notice.dart';

class VehicleControlsPageContent extends StatefulWidget {
  final BluetoothDevice device;
  final FlutterBlue flutterBlue;

  VehicleControlsPageContent(this.device, this.flutterBlue);

  @override
  State<StatefulWidget> createState() {
    return VehicleControlsPageContentState(null, null);
  }
}

class VehicleControlsPageContentState extends State<VehicleControlsPageContent> {
  BluetoothDevice device;
  FlutterBlue flutterBlue;
  List<String> eventLog = [];
  BluetoothService _rotorBTService;

  getRotorBTDeviceService() => _rotorBTService;

  VehicleControlsPageContentState(this.device, this.flutterBlue);

  void _receivedServiceResults(List<BluetoothService> results) =>
    _rotorBTService = results?.firstWhere((item) => item.uuid.toString() == RotorUtils.GATT_SERVICE_UUID, orElse: () => null);

  @override
  void initState() {
    super.initState();
    // btDeviceStateSub = widget.device.state.listen((updatedState) {
    //   setState(() {
    //     _deviceState = updatedState;
    //   });
    // });

    device.discoverServices().then(_receivedServiceResults);

    eventLog.add(RotorCommand().toShorthand());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Container(
                  color: Colors.black,
                  child: ListView.builder(
                    itemBuilder: (BuildContext bc, int i) {
                      return Text(eventLog[i]);
                    },
                    itemCount: eventLog.length,
                  ))),
          _buildControlPanel()
        ]);
  }

  Widget _buildControlPanel() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildControlPanelButton(
                "left",
                (pressingDown) =>
                    _executeCommand(RotorCommand(throttleVal: 20, throttleDir: ThrottleDirection.NEUTRAL, headingDir: HeadingDirection.PORT, headingVal: 50))),
            _buildControlPanelButton(
                "right",
                (pressingDown) =>
                    _executeCommand(RotorCommand(throttleVal: 20, throttleDir: ThrottleDirection.NEUTRAL, headingDir: HeadingDirection.STARBOARD, headingVal: 50)))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildControlPanelButton(
                "GO!",
                (pressingDown) =>
                    _executeCommand(RotorCommand(throttleVal: 20, throttleDir: ThrottleDirection.FORWARD, headingDir: HeadingDirection.NEUTRAL, headingVal: 0)),
                colorOverride: Colors.green),
            _buildControlPanelButton(
                "STOP!",
                (pressingDown) =>
                    _executeCommand(RotorCommand(throttleVal: 0, throttleDir: ThrottleDirection.NEUTRAL, headingDir: HeadingDirection.NEUTRAL, headingVal: 0)),
                colorOverride: Colors.red)
          ],
        )
      ],
    ));
  }

  Widget _buildControlPanelButton(String actionTitle, Function highlightAction,
          {Color colorOverride = RotorUtils.ROTOR_TEAL_COLOR}) =>
      Padding(
          child: RaisedButton(
            child: Text(actionTitle),
            onHighlightChanged: highlightAction,
            onPressed: () {},
            color: colorOverride,
          ),
          padding: EdgeInsets.all(4));

  _executeCommand(RotorCommand rc) {

      //TODO STU FIX THIS
//      this
//          .widget
//          .device
//          .writeCharacteristic(rotorBTCharacteristic, rc.toShorthand().codeUnits);

//      setState(() {
//        eventLog.add(rc.toShorthand());
//      });

  }

}
