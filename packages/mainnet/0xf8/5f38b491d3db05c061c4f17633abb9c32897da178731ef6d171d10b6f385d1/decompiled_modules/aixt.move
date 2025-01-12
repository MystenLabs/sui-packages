module 0xf85f38b491d3db05c061c4f17633abb9c32897da178731ef6d171d10b6f385d1::aixt {
    struct AIXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXT>(arg0, 6, b"AIXT", b"AIX Terminal", b"Al-Powered Crypto Insights: Real-Time Trends & Market Sentiment Analysis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736646678456.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIXT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

