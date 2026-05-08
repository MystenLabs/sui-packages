module 0xa2851a714f77690d78653b06a1968915fd8ac7addba0145f14847e228bda6f60::xaut {
    struct XAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUT>(arg0, 8, b"XAUT", b"Wrapped XAUT", b"ZO Finance Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAUT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XAUT>>(v0);
    }

    // decompiled from Move bytecode v7
}

