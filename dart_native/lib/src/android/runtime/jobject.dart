import 'dart:ffi';
import 'package:dart_native/src/android/runtime/functions.dart';
import 'package:dart_native/src/android/common/pointer_encoding.dart';
import 'package:ffi/ffi.dart';

import 'JObjectPool.dart';
import 'class.dart';

class JObject extends Class{
  Pointer _ptr;

  Pointer get pointer{
    return _ptr;
  }

  //init target class
  JObject(String className, Pointer ptr, List args) : super(className) {
    Pointer<Pointer<Void>> pointers;
    Pointer<Pointer<Utf8>> typePointers;
    pointers = allocate<Pointer<Void>>(count: args.length + 1);
    typePointers = allocate<Pointer<Utf8>>(count: args.length + 1);
    for (var i = 0; i < args.length; i++) {
      var arg = args[i];
      if (arg == null) {
        throw 'One of args list is null';
      }
      storeValueToPointer(arg, pointers.elementAt(i), typePointers.elementAt(i));
    }
    pointers.elementAt(args.length).value = nullptr;
    typePointers.elementAt(args.length).value = nullptr;

    _ptr = ptr == null ? nativeCreateClass(super.classUtf8(), pointers, typePointers ) : ptr;
    JObjectPool.sInstance.retain(this);

  }

  dynamic invoke(String methodName, List args, [String returnType, String isStatic]) {
    Pointer<Utf8> methodNamePtr = Utf8.toUtf8(methodName);
    Pointer<Utf8> returnTypePtr = Utf8.toUtf8(returnType);
    Pointer<Utf8> isStaticPtr = Utf8.toUtf8(isStatic);

    Pointer<Pointer<Void>> pointers;
    Pointer<Pointer<Utf8>> typePointers;
    if (args != null) {
      pointers = allocate<Pointer<Void>>(count: args.length + 1);
      typePointers = allocate<Pointer<Utf8>>(count: args.length + 1);
      for (var i = 0; i < args.length; i++) {
        var arg = args[i];
        if (arg == null) {
          throw 'One of args list is null';
        }
        storeValueToPointer(arg, pointers.elementAt(i), typePointers.elementAt(i));
      }
      pointers.elementAt(args.length).value = nullptr;
      typePointers.elementAt(args.length).value = nullptr;
    }
    Pointer<Void> invokeMethodRet =
        nativeInvokeNeo(_ptr, methodNamePtr, pointers, typePointers
            , returnTypePtr, isStaticPtr);
    dynamic result = loadValueFromPointer(invokeMethodRet, returnType);
    if (pointers != null) {
      free(pointers);
    }
    if (typePointers != null) {
      free(typePointers);
    }
    return result;
  }

  release() {
    if (JObjectPool.sInstance.release(this)) {
      nativeReleaseClass(_ptr);
    }
  }

  @override
  int compareTo(other) {
    if (other is JObject && other._ptr == _ptr) {
      return 0;
    }
    return 1;
  }
}
