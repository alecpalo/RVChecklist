import 'package:flutter/material.dart';
import 'package:rv_checklist/resources/colors.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isPushNotificationsEnabled = true;
  bool _isEmailNotificationsEnabled = false;
  bool _isSMSNotificationsEnabled = false;

  void _togglePushNotification(bool value) {
    setState(() {
      _isPushNotificationsEnabled = value;
    });
  }

  void _toggleEmailNotification(bool value) {
    setState(() {
      _isEmailNotificationsEnabled = value;
    });
  }

  void _toggleSMSNotification(bool value) {
    setState(() {
      _isSMSNotificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
          style: TextStyle(
            color: AppColors.textOne,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.secondaryColor), // Back arrow color
        backgroundColor: AppColors.primaryColor, // Set AppBar color in Settings
      ),
      backgroundColor: AppColors.primaryColor, // Set main screen background color in Settings
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Push Notifications'),
            value: _isPushNotificationsEnabled,
            onChanged: _togglePushNotification,
            subtitle: Text('Receive notifications directly on your device.'),
          ),
          SwitchListTile(
            title: Text('Email Notifications'),
            value: _isEmailNotificationsEnabled,
            onChanged: _toggleEmailNotification,
            subtitle: Text('Receive notifications via email.'),
          ),
          SwitchListTile(
            title: Text('SMS Notifications'),
            value: _isSMSNotificationsEnabled,
            onChanged: _toggleSMSNotification,
            subtitle: Text('Receive text message notifications.'),
          ),
        ],
      ),
    );
  }
}
