package com.dartnative.dart_native_example;

import io.flutter.Log;

/**
 * Created by huizzzhou on 2020/6/4.
 */
public class constructorTest {

    private final String TAG = "dart_java";

    private String name = "none";

    constructorTest(String str){
        Log.d(TAG, this.name);
        this.name = str;
        Log.d(TAG, this.name);
    }

    public String getString(){
        return name;
    }

}
