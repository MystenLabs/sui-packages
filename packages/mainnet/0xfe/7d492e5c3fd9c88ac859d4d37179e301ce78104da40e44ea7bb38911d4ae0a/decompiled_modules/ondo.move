module 0xfe7d492e5c3fd9c88ac859d4d37179e301ce78104da40e44ea7bb38911d4ae0a::ondo {
    struct ONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDO>(arg0, 8, b"ONDO", b"Wrapped Ondo", b"ZO Finance Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONDO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ONDO>>(v0);
    }

    // decompiled from Move bytecode v6
}

