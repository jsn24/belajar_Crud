import 'package:flutter/material.dart';
import 'package:test_crud/src/api/api_service.dart';
import 'package:test_crud/src/model_class/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  Profile profile;

  FormAddScreen({this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldFirstNameValid;
  bool _isFieldEmailValid;
  bool _isFieldLastNameValid;
  bool _isFieldAvatarValid;
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAvatar = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldFirstNameValid = true;
      _controllerFirstName.text = widget.profile.first_name;
      // _isFieldEmailValid = true;
      // _controllerSalary.text = widget.profile.employee_salary.toString();
      // _isFieldAgeValid = true;
      // _controllerAge.text = widget.profile.employee_age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldName2(),
                _buildTextFieldEmail(),
                _buildTextFieldAvatar(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldFirstNameValid == null ||
                          _isFieldLastNameValid == null ||
                          _isFieldEmailValid == null ||
                          _isFieldAvatarValid == null ||
                          !_isFieldFirstNameValid ||
                          !_isFieldLastNameValid ||
                          !_isFieldEmailValid ||
                          !_isFieldAvatarValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String Firstname = _controllerFirstName.text.toString();
                      String Lastname = _controllerLastName.text.toString();
                      String email = _controllerEmail.text.toString();
                      String avatar = _controllerAvatar.text.toString();
                      Profile profile =
                          Profile(first_name: Firstname, last_name: Lastname, email: email, avatar: avatar);
                      if (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First Name",
        // errorText: _isFieldNameValid == null || _isFieldNameValid
        //     ? null
        //     : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstNameValid) {
          setState(() => _isFieldFirstNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldName2() {
    return TextField(
      controller: _controllerLastName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Last Name",
        // errorText: _isFieldNameValid == null || _isFieldNameValid
        //     ? null
        //     : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLastNameValid) {
          setState(() => _isFieldLastNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        // errorText: _isFieldEmailValid == null || _isFieldEmailValid
        //     ? null
        //     : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAvatar() {
    return TextField(
      controller: _controllerAvatar,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Avatar",
        // errorText: _isFieldAgeValid == null || _isFieldAgeValid
        //     ? null
        //     : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAvatarValid) {
          setState(() => _isFieldAvatarValid = isFieldValid);
        }
      },
    );
  }
}