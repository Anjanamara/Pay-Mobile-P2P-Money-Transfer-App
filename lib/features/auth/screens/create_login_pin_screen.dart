// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants/global_constants.dart';
import 'package:money_transfer_app/features/auth/services/auth_service.dart';
import 'package:money_transfer_app/providers/user_provider.dart';
import 'package:money_transfer_app/widgets/number_dial_pad.dart';
import 'package:money_transfer_app/widgets/pin_input_field.dart';
import 'package:provider/provider.dart';

class CreateLoginPinScreen extends StatefulWidget {
  static const String route = "/create-login-pin-screen";
  const CreateLoginPinScreen({super.key});

  @override
  State<CreateLoginPinScreen> createState() => _CreateLoginPinScreenState();
}

class _CreateLoginPinScreenState extends State<CreateLoginPinScreen> {
  var selectedindex = 0;
  String pin = '';
  String confirmPin = '';
  String hello = "";

  final AuthService authService = AuthService();

  void createPinUser() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    authService.createPin(
      context: context,
      pin: pin,
      username: user.username,
      confirmPin: confirmPin,
    );
  }

  getUserData() async {
    await authService.obtainTokenAndUserData(context);
  }

  addDigit(int digit) {
    if (pin.length > 3) {
      return;
    }
    setState(() {
      pin = pin + digit.toString();
      print('pin is $pin');
      selectedindex = pin.length;
    });
  }

  backspace() {
    if (pin.isEmpty) {
      return;
    }
    setState(() {
      pin = pin.substring(0, pin.length - 1);
      selectedindex = pin.length;
    });
  }

  addDigitForConfirm(int digit) {
    if (confirmPin.length > 3) {
      //createPinUser();
      return;
    }

    setState(() {
      confirmPin = confirmPin + digit.toString();
      print('Confirm pin is $confirmPin');
      selectedindex = confirmPin.length;
      if (confirmPin.length > 3) {
        createPinUser();
        getUserData();
      }
    });
  }

  backspaceForConfirm() {
    if (confirmPin.isEmpty) {
      return;
    }
    setState(() {
      confirmPin = confirmPin.substring(0, confirmPin.length - 1);
      selectedindex = confirmPin.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: heightValue50,
                ),
                Image.asset(
                  "assets/images/full_logo.png",
                  height: heightValue110,
                ),
                SizedBox(
                  height: heightValue20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                        fontSize: heightValue25,
                      ),
                    ),
                    Text(
                      user.fullname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: heightValue25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightValue20,
                ),
                pin.length > 3
                    ? Text(
                        "Confirm your 4 digit pin",
                        style: TextStyle(fontSize: heightValue20),
                      )
                    : Text(
                        "Create a 4 digit pin for your account",
                        style: TextStyle(fontSize: heightValue25),
                      ),
                SizedBox(
                  height: heightValue30,
                ),
                pin.length > 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinInputField(
                            index: 0,
                            selectedIndex: selectedindex,
                            pin: confirmPin,
                          ),
                          PinInputField(
                              index: 1,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                          PinInputField(
                              index: 2,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                          PinInputField(
                              index: 3,
                              selectedIndex: selectedindex,
                              pin: confirmPin),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinInputField(
                            index: 0,
                            selectedIndex: selectedindex,
                            pin: pin,
                          ),
                          PinInputField(
                              index: 1, selectedIndex: selectedindex, pin: pin),
                          PinInputField(
                              index: 2, selectedIndex: selectedindex, pin: pin),
                          PinInputField(
                              index: 3, selectedIndex: selectedindex, pin: pin),
                        ],
                      ),
                SizedBox(
                  height: heightValue20,
                ),
                pin.length > 3
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(1),
                                  numberText: '1'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(2),
                                  numberText: '2'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(3),
                                  numberText: '3'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(4),
                                  numberText: '4'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(5),
                                  numberText: '5'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(6),
                                  numberText: '6'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(7),
                                  numberText: '7'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(8),
                                  numberText: '8'),
                              NumberDialPad(
                                  onTap: () => addDigitForConfirm(9),
                                  numberText: '9'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                onTap: () {},
                                numberText: '',
                              ),
                              NumberDialPad(
                                onTap: () => addDigitForConfirm(0),
                                numberText: '0',
                              ),
                              TextButton(
                                onPressed: () {
                                  backspaceForConfirm();
                                },
                                child: Icon(Icons.backspace_outlined,
                                    color: Colors.black.withBlue(40), size: 30),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: heightValue30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(1), numberText: '1'),
                              NumberDialPad(
                                  onTap: () => addDigit(2), numberText: '2'),
                              NumberDialPad(
                                  onTap: () => addDigit(3), numberText: '3'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(4), numberText: '4'),
                              NumberDialPad(
                                  onTap: () => addDigit(5), numberText: '5'),
                              NumberDialPad(
                                  onTap: () => addDigit(6), numberText: '6'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(
                                  onTap: () => addDigit(7), numberText: '7'),
                              NumberDialPad(
                                  onTap: () => addDigit(8), numberText: '8'),
                              NumberDialPad(
                                  onTap: () => addDigit(9), numberText: '9'),
                            ],
                          ),
                          SizedBox(
                            height: heightValue20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberDialPad(onTap: () {}, numberText: ''),
                              NumberDialPad(
                                  onTap: () => addDigit(0), numberText: '0'),
                              TextButton(
                                onPressed: () => backspace(),
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.black.withBlue(40),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightValue15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: heightValue30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
