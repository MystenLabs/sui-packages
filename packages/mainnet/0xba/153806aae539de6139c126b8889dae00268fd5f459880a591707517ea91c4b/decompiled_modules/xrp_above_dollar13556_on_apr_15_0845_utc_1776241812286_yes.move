module 0xba153806aae539de6139c126b8889dae00268fd5f459880a591707517ea91c4b::xrp_above_dollar13556_on_apr_15_0845_utc_1776241812286_yes {
    struct XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES>(arg0, 0, b"XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES", b"XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286 YES", b"XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP_ABOVE_DOLLAR13556_ON_APR_15_0845_UTC_1776241812286_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

