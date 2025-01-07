module 0xefb48755173671fd3992daff9b5fdeb0961a492e4209b85175ca2388835f4467::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<TEMPLATE>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<TEMPLATE>(arg0, b"TOKEN_SYMBOL", b"TOKEN_NAME", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-image.tucanadev.net/icon/280c49df-b8ee-47d4-8cbb-7f7a137cad58_image.jpg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00530719a9a87c163bcb45ca5c0f75abd1d521914225a9a0c2ab522fe24958da63966d2c64658b4f05f6849aa9db6f2876cb515c2a0f042e4024fdc917bcec4b032b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

