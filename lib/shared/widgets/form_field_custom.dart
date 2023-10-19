import 'package:flutter/material.dart';

class FormFieldCustom extends StatelessWidget {
  final labelText;
  final isObscured;
  final String? Function(String?)? validator;
  final Function(String) onChanged;

  const FormFieldCustom(
      {super.key,
      required this.labelText,
      this.isObscured = false,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              label: Text((labelText != null) ? labelText : "Digite Aqui"),
              contentPadding: EdgeInsets.zero),
          onChanged: onChanged,
          validator: validator,
          obscureText: isObscured,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
