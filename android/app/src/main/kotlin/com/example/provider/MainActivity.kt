package com.example.channel_method

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val channel = "battery"
    private val method = "getBatteryLevel"
    private val errorCode = "MESSAGE_NOT_SENT"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        configureMethodChannel(flutterEngine)
    }

    private fun showToast(message: String?, result: MethodChannel.Result) {
        if (message != null) {
            Toast.makeText(this, message, Toast.LENGTH_LONG).show()
        } else {
            result.error(errorCode, "Message not sent.", null)
        }
    }

    private fun configureMethodChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method.equals(method)) {
                val message: String? = call.argument("message")
                showToast(message, result)
            } else {
                result.notImplemented()
            }
        }
    }

}
