import 'dart:ffi';

import 'package:dart_native/dart_native.dart';
import 'package:dart_native_example/android/entity.dart';

class constructorTest extends JObject {
  constructorTest(String s, [Pointer ptr])
      : super("com/dartnative/dart_native_example/constructorTest", ptr, [s]);

  String getString() {
    return invoke('getString', [], "Ljava/lang/String;", "");
  }

  void testStatic(){
    return invoke('testStatic', [], "V", "static");
  }

  Entity createEntity(){
    return new Entity(invoke('createEntity', [], 'Lcom/dartnative/dart_native_example/Entity;',""));
  }

}

class InnerC extends JObject {
  InnerC([Pointer ptr]) : super("com/dartnative/dart_native_example/constructorTest\$InnerC", ptr, []);

  void testInnerC() {
    return invoke('testInnerC', [], 'V', "static");
  }
}