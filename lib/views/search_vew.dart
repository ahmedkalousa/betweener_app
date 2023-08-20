import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controllers/user_controller.dart';

class SearchView extends StatefulWidget {
  static String id = '/SearchView';
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<List<UserClass>>? futureUsers;

  void search_data() {
    if (_formKey.currentState!.validate()) {
      getUsers(context, nameController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kScaffoldColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomTextFormField(
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      futureUsers = getUsers(context, value);
                    }
                  });
                },
                controller: nameController,
                label: 'name',
                hint: 'Enter..',
              ),
              SizedBox(
                height: 24,
              ),
              SecondaryButtonWidget(
                onTap: () {
                  setState(() {
                    search_data();
                  });
                },
                text: 'Search',
                width: 150,
              ),
              if (futureUsers != null)
                Expanded(
                  child: FutureBuilder<List<UserClass>>(
                      future: futureUsers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print('${snapshot.data}' + 'sssssssssssss');

                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Text('${snapshot.data?[index].name}'),
                                color: Colors.grey[500],
                                padding: EdgeInsets.all(24),
                              );
                            },
                            separatorBuilder: (contexr, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Text('loading');
                      }),
                )
            ],
          ),
        ),
      ),
    );
  }
}
