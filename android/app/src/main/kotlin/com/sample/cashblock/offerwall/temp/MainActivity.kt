package com.sample.cashblock.offerwall.temp

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import com.avatye.cashblock.CashBlockSDK
import com.avatye.cashblock.base.component.domain.entity.user.GenderType
import com.avatye.cashblock.base.component.domain.entity.user.Profile
import com.avatye.cashblock.feature.offerwall.CashBlockOfferwall
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * 캐시블록의 “오퍼월(참여형 광고)”을 실행하기 위해서는 “초기화 및 기본설정”이 완료 되어야 합니다.

 * SDK 초기화 → 세션연동 → 유저 정보 연동 → 오퍼월 실행
 * application -> CashBlockSDK.initialize()
 * Main activity -> CashBlockSDK.sessionStart(), CashBlockSDK.sessionEnd()
 * profile -> CashBlockSDK.setUserProfile()
 * launch
 */
class MainActivity : FlutterActivity() {
    companion object {
        val METHOD_CHANNEL = "avatye.cashblock.offerwall/sample"
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "cashBlock_init" -> {
                        val userId: String = call.arguments.toString()
                        setUserProfile(userId = userId)
                    }
                    "cashBlock_start" -> {
                        launchOfferwall()
                    }
                }
            }
    }


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }


    /** 캐시블록 - 세션 시작 */
    private fun startBlockSession() {
        Log.e("Core@Block", "MainActivity -> startBlockSession")
        CashBlockSDK.sessionStart(context = this)
    }


    /** 사용자 프로필을 등록 (필수) */
    private fun setUserProfile(userId: String) {
        CashBlockSDK.setUserProfile(
            context = this,
            profile = Profile(
                userId = userId,
                birthYear = 2000,
                gender = GenderType.MALE
            )
        )

        Log.e("Core@Block", "MainActivity -> setUserProfile -> { getUserProifle: ${CashBlockSDK.getUserProfile(context = this)} }")
    }


    /** 캐시블록 - 오퍼월 시작  */
    private fun launchOfferwall() {
        Log.e("Core@Block", "MainActivity -> launchOfferwall")
        CashBlockOfferwall.launch(context = this)
    }


    /**
     * 캐시블록 - 세션 종료
     * 메인 액티비티의 'onDestroy()' 함수에 적용
     */
    override fun onDestroy() {
        Log.e("Core@Block", "MainActivity -> onDestroy")
        CashBlockSDK.sessionEnd(context = this)
        super.onDestroy()
    }
}
