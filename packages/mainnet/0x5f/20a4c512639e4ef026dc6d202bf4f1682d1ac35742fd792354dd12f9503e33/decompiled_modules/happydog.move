module 0x5f20a4c512639e4ef026dc6d202bf4f1682d1ac35742fd792354dd12f9503e33::happydog {
    struct HAPPYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYDOG>(arg0, 6, b"HAPPYDOG", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPYDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

