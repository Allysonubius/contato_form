// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_print, import_of_legacy_library_into_null_safe, unnecessary_import, implementation_imports, duplicate_import

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contato Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ContatoModel contato = new ContatoModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contato.nome ?? ''),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: <Widget>[
              TextFormField(
                validator: nomeValidator(),
                onChanged: updateNome,
                decoration: InputDecoration(labelText: "NOME"),
                maxLength: 100,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                onChanged: updateTelefone,
                decoration: InputDecoration(labelText: "CELULAR"),
              ),
              TextFormField(
                validator: emailValidator(),
                onChanged: updateEmail,
                decoration: InputDecoration(labelText: "E-MAIL"),
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: cpfValidator(),
                onChanged: updateCpf,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "CPF"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(
                        '\n\n NOME: ${contato.nome},TELEFONE: ${contato.telefone},E_MAIL: ${contato.email},CPF: ${contato.cpf} \n');
                  }
                },
                child: Text('SALVAR'),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void updateNome(nome) => contato.nome = nome;
  void updateTelefone(telefone) => contato.telefone = telefone;
  void updateEmail(email) => contato.email = email;
  void updateCpf(cpf) => contato.cpf = cpf;

  FieldValidator nomeValidator() {
    return MultiValidator([
      RequiredValidator(errorText: 'CAMPO OBRIGATORIO'),
      MinLengthValidator(3, errorText: 'TAMANHO MINIMO DE 3 CARACTERES'),
      MaxLengthValidator(100, errorText: 'TAMANHO MAXIMO DE 100 CARACTERES'),
    ]);
  }

  FieldValidator emailValidator() {
    return MultiValidator([
      EmailValidator(errorText: 'E-MAIL INVALIDO'),
      RequiredValidator(errorText: 'CAMPO OBRIGATORIO'),
      MinLengthValidator(3, errorText: 'TAMANHO MINIMO DE 03 CARACTERES'),
      MaxLengthValidator(100, errorText: 'TAMANHO MAXIMO DE 100 CARACTERES')
    ]);
  }

  FieldValidator cpfValidator(  ) {
    return MultiValidator([
      RequiredValidator(errorText: 'CAMPO OBRIGATORIO'),
    ]);
  }
}

class ContatoModel {
  String? nome;
  String? email;
  String? cpf;
  String? telefone;
  ContatoType? type;
}

// ignore: constant_identifier_names
enum ContatoType { CELULAR, TRABALHO, FAVORITO, CASA }
