module 0xf008ac7eb6eaec7f60dda9c54aa907370e17242396b036ed410445ea12017f5::sndk {
    struct SNDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNDK>(arg0, 9, b"SNDK", b"Sandisk Corporation", b"ZO Virtual Coin for Sandisk Corporation", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNDK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNDK>>(v0);
    }

    // decompiled from Move bytecode v7
}

