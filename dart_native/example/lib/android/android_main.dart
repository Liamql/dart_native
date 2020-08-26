import 'package:flutter/material.dart';
import 'package:dart_native_example/android/runtimestub.dart';
import 'dart:ffi' as ffi;

import 'package:dart_native/src/android/dart_java.dart';
import 'constructorTest.dart';

class AndroidApp extends StatefulWidget {
  @override
  _AndroidAppState createState() => _AndroidAppState();
}

class _AndroidAppState extends State<AndroidApp> {

  RuntimeStub stub = RuntimeStub();

  static final int _TEST_COUNT = 10000;

  int _ffiInt = 0;

  int _methodInt = 0;

  int _ffiDouble = 0;

  int _methodDouble = 0;

  int _methodString = 0;

  int _ffiByte = 0;

  int _ffiString = 0;

  int _ffiShort = 0;

  int _ffiLong = 0;

  int _ffiFloat = 0;

  int _ffiChar = 0;

  String _str = "null";

  @override
  void initState() {
    super.initState();
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testIntMethodChannel();
                },
                child: Text('MethodChannel int : $_methodInt\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testDoubleMethodChannel();
                },
                child: Text('MethodChannel double : $_methodDouble\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testStringMethodChannel();
                },
                child: Text('MethodChannel string : $_methodString\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testIntFFIso();
                },
                child: Text('FFI int : $_ffiInt\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testDoubleFFIso();
                },
                child: Text('FFI double : $_ffiDouble\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testStringFFIso();
                },
                child: Text('FFI String : $_ffiString\n')),
          ),
        ),
        Expanded(
          child: new SizedBox(
            width: 800, // specific value
            child: new FlatButton(
                onPressed: () {
                  testStaticInnerC();
                },
                child: Text('testConstructor : $_ffiInt\n')),
          ),
        ),
      ]),
    ));
  }

  void testStaticInnerC() async {
    print("testStaticInnerC");
    InnerC().testInnerC();
  }

  void testStatic() async {
    print("testStatic");
    constructorTest("changeName!").getString();
    constructorTest("changeName!").testStatic();
  }

  void testEntity() async {
    print("testEntity");
    constructorTest("changeName!").createEntity();
  }

  void testConstructor() async {
    print("testConstructor");
    String res = constructorTest("changeName!").getString();
    setState(() {
      _str = res;
    });
  }

  void testIntMethodChannel() async {
    print("testIntMethodChannel");
    var startMs = currentTimeMillis();
    for (int i = 0; i < _TEST_COUNT; i++) {
      await DartJava.platformVersionInt;
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testIntMethodChannel ,cost ms :" + useMs.toString());
    setState(() {
      _methodInt = useMs;
    });
  }

  void testIntFFIso() async {
    print("testIntFFI");
    var startMs = currentTimeMillis();
    int resultInt;
    for (int i = 0; i < _TEST_COUNT; i++) {
      resultInt = stub.getInt(10);
    }
//    print('getInt result:$resultInt');
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testIntFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiInt = useMs;
    });
  }


  void testDoubleMethodChannel() async {
    print("testDoubleMethodChannel");
    var startMs = currentTimeMillis();
    for (int i = 0; i < _TEST_COUNT; i++) {
      await DartJava.platformVersionDouble;
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testDoubleMethodChannel ,cost ms :" + useMs.toString());
    setState(() {
      _methodDouble = useMs;
    });
  }

  void testStringMethodChannel() async {
    print("testStringMethodChannel");
    var startMs = currentTimeMillis();
    for (int i = 0; i < _TEST_COUNT; i++) {
      await DartJava.platformVersionString;
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testStringMethodChannel ,cost ms :" + useMs.toString());
    setState(() {
      _methodString = useMs;
    });
  }

  void testStringFFIso() async {
    print("testStringFFI");
    var startMs = currentTimeMillis();
    String res;
    for (int i = 0; i < _TEST_COUNT; i++) {
      res = stub.getString("test is success?");
    }
//    print('getString result:$res');
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testStringFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiString = useMs;
    });
  }



  void testDoubleFFI() async {
    print("testDoubleFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final DoublePlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeDoubleFunction>>("getPlatformDouble")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testDoubleFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiDouble = useMs;
    });
  }


  void testDoubleFFIso() async {
    print("testDoubleFFI");
    var startMs = currentTimeMillis();
    double resultDouble;
    for (int i = 0; i < _TEST_COUNT; i++) {
      resultDouble = stub.getDouble(10.0);
    }
//    print('getDouble result:$resultDouble');
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testDoubleFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiDouble = useMs;
    });
  }

  void testByteFFI() async {
    print("testByteFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final BytePlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeByteFunction>>("getPlatformByte")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testByteFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiByte = useMs;
    });
  }

  void testShortFFI() async {
    print("testShortFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final ShortPlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeShortFunction>>("getPlatformShort")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testShortFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiShort = useMs;
    });
  }

  void testLongFFI() async {
    print("testLongFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final LongPlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeLongFunction>>("getPlatformLong")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testLongFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiLong = useMs;
    });
  }

  void testFloatFFI() async {
    print("testFloatFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final FloatPlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeFloatFunction>>("getPlatformFloat")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testFloatFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiFloat = useMs;
    });
  }

  void testCharFFI() async {
    print("testCharFFI");
    var startMs = currentTimeMillis();
    final ffi.DynamicLibrary nativePlatformLib =
        ffi.DynamicLibrary.open("libtest_lib.so");

    for (int i = 0; i < _TEST_COUNT; i++) {
      final CharPlatformFunction nativePlatform = nativePlatformLib
          .lookup<ffi.NativeFunction<NativeCharFunction>>("getPlatformChar")
          .asFunction();
      nativePlatform();
    }
    var endMs = currentTimeMillis();
    var useMs = endMs - startMs;
    print("testCharFFI ,cost ms :" + useMs.toString());
    setState(() {
      _ffiChar = useMs;
    });
  }
}

typedef IntPlatformFunction = int Function();
typedef NativeIntFunction = ffi.Int32 Function();

typedef DoublePlatformFunction = double Function();
typedef NativeDoubleFunction = ffi.Double Function();

typedef BytePlatformFunction = int Function();
typedef NativeByteFunction = ffi.Int8 Function();

typedef ShortPlatformFunction = int Function();
typedef NativeShortFunction = ffi.Int16 Function();

typedef LongPlatformFunction = int Function();
typedef NativeLongFunction = ffi.Int64 Function();

typedef FloatPlatformFunction = double Function();
typedef NativeFloatFunction = ffi.Float Function();

typedef CharPlatformFunction = int Function();
typedef NativeCharFunction = ffi.Uint16 Function();
