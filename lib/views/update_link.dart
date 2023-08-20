import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import 'main_app_view.dart';

class UpdateLinkScreen extends StatefulWidget {
  static String id = '/UpdateLinkScreen';
  const UpdateLinkScreen({super.key});

  @override
  State<UpdateLinkScreen> createState() => _UpdateLinkScreenState();
}

class _UpdateLinkScreenState extends State<UpdateLinkScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? id;

  void update_link() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
      };

      updateLink(context, id!, body).catchError(
        (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
      Navigator.pushNamed(context, MainAppView.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    titleController.text = data['title'];
    linkController.text = data['link'];
    id = data['id'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('Edit Link'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: titleController,
                hint: 'snapchat',
                label: 'title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the titl';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextFormField(
                controller: linkController,
                hint: 'https://www.snapchat.com',
                label: 'link',
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the Link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 46,
              ),
              SecondaryButtonWidget(
                onTap: () {
                  setState(() {
                    update_link();
                  });
                },
                width: 200,
                text: 'Save',
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
