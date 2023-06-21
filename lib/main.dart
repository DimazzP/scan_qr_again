import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRCodeScannerPage(),
    );
  }
}

class QRCodeScannerPage extends StatefulWidget {
  // const QRCodeScannerPage({super.key});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  // PickedFile? _pickedImage;
  String? pathName;
  String? result;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pathName = pickedFile?.path;
    });
  }

  Future<void> _checkText() async {
    try {
      result = await Scan.parse(pathName!);
      setState(() {});
    } catch (e) {}

    // return result!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: Text('from gallery')),
            Text('${pathName.toString()}'),
            ElevatedButton(
                onPressed: () {
                  _checkText();
                },
                child: Text('Result')),
            Text('${result}')
          ],
        ),
      ),
    ));
  }
}
