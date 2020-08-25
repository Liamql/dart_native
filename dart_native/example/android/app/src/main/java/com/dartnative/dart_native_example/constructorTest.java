package com.dartnative.dart_native_example;

import io.flutter.Log;

/**
 * Created by huizzzhou on 2020/6/4.
 */
public class constructorTest {

    private static final String TAG = "dart_java";

    private String name = "none";

    int[] intArray = new int[]{5,2,3,4};

    constructorTest(String str){
        Log.d(TAG, this.name);
        this.name = str;
        Log.d(TAG, this.name);
    }

    public String getString(){
        return name;
    }

    public static void testStatic(){
        Log.d(TAG, "testStatic");
    }

    public Entity createEntity(){
        return new Entity();
    }

}
