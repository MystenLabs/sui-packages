module 0x40276d8ba092456e933de22303b8149d50c546d03a7778626af47c6be8e8e9bd::amazon_amzn_above_dollar24984_on_apr_22_2000_utc_1776862806273_no {
    struct AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO>(arg0, 0, b"AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO", b"AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273 NO", b"AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAZON_AMZN_ABOVE_DOLLAR24984_ON_APR_22_2000_UTC_1776862806273_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

