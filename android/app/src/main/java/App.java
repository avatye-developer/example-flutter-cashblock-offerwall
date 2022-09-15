import android.app.Application;

import com.avatye.cashblock.CashBlockSDK;

public class App extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        /**
         * CashBlock SDK 초기화
         * 연동키(appId, appSecret) 는 아바티 영업 담당자(business@avatye.com)를 통해 발급이 가능 합니다.
         * 정식으로 발급된 연동키를 사용해야만 정산이 가능 합니다.
         */
        CashBlockSDK.initialize(
                this,
                "98d4d4c35d594451b21f54718e2bc986",
                "c395dbe200ad4493ade96fb92c988fcf1c8df2d3687d49a9ab6f31f7c05e2bf4"
        );
    }
}
