import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (selectedImage == null) {
      return;
    }

    setState(() {
      _storedImage = File(selectedImage.path);
    });

    widget.onPickImage(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: Text(
        'Take Picture',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      onPressed: _takePicture,
    );

    if (_storedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _storedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      width: double.infinity,
      alignment: Alignment.center,
      height: 250,
      child: content,
    );
  }
}
