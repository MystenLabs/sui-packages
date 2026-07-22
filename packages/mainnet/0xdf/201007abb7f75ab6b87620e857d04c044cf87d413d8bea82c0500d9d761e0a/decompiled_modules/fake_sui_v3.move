module 0xdf201007abb7f75ab6b87620e857d04c044cf87d413d8bea82c0500d9d761e0a::fake_sui_v3 {
    struct FAKE_SUI_V3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI_V3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI_V3>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI_V3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI_V3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

