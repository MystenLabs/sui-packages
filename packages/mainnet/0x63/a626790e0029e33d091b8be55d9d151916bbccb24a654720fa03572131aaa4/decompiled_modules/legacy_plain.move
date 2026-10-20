module 0x63a626790e0029e33d091b8be55d9d151916bbccb24a654720fa03572131aaa4::legacy_plain {
    struct LEGACY_PLAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGACY_PLAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGACY_PLAIN>(arg0, 9, b"LEGACYTEST", b"Legacy admission test", b"Worthless test currency", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGACY_PLAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGACY_PLAIN>>(v1);
    }

    // decompiled from Move bytecode v7
}

