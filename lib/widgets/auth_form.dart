import "package:flutter/material.dart";

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, bool isLogin,
      String userType, String userBloodGroup, BuildContext ctx) submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = "";
  String _userPassword = "";
  String _userType = "donor";
  String _userBloodGroup = "";
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword, _isLogin, _userType,
          _userBloodGroup, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "HealTech",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Card(
            margin: EdgeInsets.all(50),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          key: ValueKey("email"),
                          onSaved: (value) => _userEmail = value,
                          validator: (enteredEmail) {
                            if (enteredEmail.isEmpty ||
                                (!enteredEmail.contains("@")))
                              return "Enter a valid email";
                            else
                              return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email Address",
                          ),
                        ),
                        if (!_isLogin)
                          Column(
                            children: [
                              ListTile(
                                title: const Text('Hospital'),
                                leading: Radio(
                                  value: "hospital",
                                  groupValue: _userType,
                                  onChanged: (value) {
                                    setState(() {
                                      _userType = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Individual'),
                                leading: Radio(
                                  value: "donor",
                                  groupValue: _userType,
                                  onChanged: (value) {
                                    setState(() {
                                      _userType = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        if (_isLogin == false)
                          TextFormField(
                            key: ValueKey("bloodgroup"),
                            onSaved: (u) => _userBloodGroup = u,
                            decoration: InputDecoration(
                                labelText:
                                    "Enter blood group if individual is donor",
                                labelStyle: TextStyle(fontSize: 14)),
                          ),
                        TextFormField(
                          key: ValueKey("password"),
                          onSaved: (v) => _userPassword = v,
                          validator: (enteredPassword) {
                            if (enteredPassword.isEmpty ||
                                enteredPassword.length < 8)
                              return "Enter atleast 8 characters";
                            else
                              return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                        ),
                        SizedBox(height: 12),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          RaisedButton(
                            child: _isLogin ? Text("Login") : Text("Sign Up"),
                            onPressed: _trySubmit,
                          ),
                        if (!widget.isLoading)
                          FlatButton(
                            onPressed: () =>
                                setState(() => _isLogin = !_isLogin),
                            child: _isLogin
                                ? Text("Create new account")
                                : Text("Go back to login"),
                          ),
                      ],
                    )),
              ),
            ),
          ),
          Image.asset(
            "assets/qr code.jpg",
            scale: 5,
          )
        ],
      ),
    );
  }
}
