import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  File? _image;

  void _addNewPlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(userPlacesProvider.notifier)
          .addPlace(Place(title: _title, image: _image!));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Place',
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text(
                    'Title',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ImageInput(
                onPickImage: (pickedImage) {
                  _image = pickedImage;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const LocationInput(),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _addNewPlace,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
