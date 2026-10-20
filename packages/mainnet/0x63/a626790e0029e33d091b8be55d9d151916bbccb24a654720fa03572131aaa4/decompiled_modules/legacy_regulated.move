module 0x63a626790e0029e33d091b8be55d9d151916bbccb24a654720fa03572131aaa4::legacy_regulated {
    struct LEGACY_REGULATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGACY_REGULATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LEGACY_REGULATED>(arg0, 9, b"LEGACYTEST", b"Legacy admission test", b"Worthless test currency", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LEGACY_REGULATED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGACY_REGULATED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGACY_REGULATED>>(v2);
    }

    // decompiled from Move bytecode v7
}

