package com.example.apptest

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.hardware.camera2.CameraManager

class MainActivity: FlutterActivity() {
  private val CHANNEL = "example.my.strobe/strobe"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if(call.method == "strobeIt"){
        val on = call.argument<String>("isOn")
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        
        if(on == "true"){
            try{
                val cam = cameraManager.getCameraIdList()[0]
                cameraManager.setTorchMode(cameraManager.getCameraIdList()[0], false)
            }
            catch(ex: Exception){
                result.notImplemented();
            }
            result.success(null);
        }else{
            try{
                val cam = cameraManager.getCameraIdList()[0]
                cameraManager.setTorchMode(cameraManager.getCameraIdList()[0], true)
            }
            catch(ex: Exception){
                result.notImplemented();
            }
            result.success(null);
        }
      }
      else{
        result.notImplemented();
      }
    }
  }
}
