module 0x104ebfbab951e0e048bf6445544467d23d4d29838e6c58f3064845ff42d83dd9::ET69 {
    struct ET69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ET69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ET69>(arg0, 6, b"ELON vs TRUMP", b"ET69", b"Elon vs Trump, Buy this coin in support of \"RELEASING THOSE DOCUMENTS\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ET69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ET69>>(v1);
    }

    // decompiled from Move bytecode v6
}

