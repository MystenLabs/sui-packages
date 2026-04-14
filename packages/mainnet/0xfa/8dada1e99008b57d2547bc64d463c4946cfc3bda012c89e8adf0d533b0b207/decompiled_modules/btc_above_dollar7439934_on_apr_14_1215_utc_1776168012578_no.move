module 0xfa8dada1e99008b57d2547bc64d463c4946cfc3bda012c89e8adf0d533b0b207::btc_above_dollar7439934_on_apr_14_1215_utc_1776168012578_no {
    struct BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO>(arg0, 0, b"BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO", b"BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578 NO", b"BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC_ABOVE_DOLLAR7439934_ON_APR_14_1215_UTC_1776168012578_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

