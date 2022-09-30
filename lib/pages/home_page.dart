import 'package:flutter/material.dart';
import 'package:bot/services/data_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  String _text = "";
  bool _isLoading = false;

// To get data from the API
  Future<void> getData() async {
    final result = _formKey.currentState!.validate();
    if (result) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await getDataFromOpenAPI(_textEditingController.text);
        setState(() {
          _text = response.choices[0].text;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _text = "Server Error";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sirenbot"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                    controller: _textEditingController,
                    validator: (value) {
                      return value!.isEmpty ? 'Enter Text' : null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: "Text",
                        hintText: "Enter Text",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )))),
              ),
              const SizedBox(
                height: 35,
              ),
              _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : _text.isNotEmpty
                      ? Flexible(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                _text.trim(),
                                style: const TextStyle(
                                    color: Colors.blueAccent, fontSize: 26),
                              ),
                            ),
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getData,
          tooltip: "Send",
          child: const Icon(
            Icons.send,
          )),
    );
  }
}
