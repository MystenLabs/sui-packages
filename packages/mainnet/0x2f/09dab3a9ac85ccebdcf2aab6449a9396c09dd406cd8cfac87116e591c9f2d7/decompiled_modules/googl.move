module 0x2f09dab3a9ac85ccebdcf2aab6449a9396c09dd406cd8cfac87116e591c9f2d7::googl {
    struct GOOGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGL>(arg0, 9, b"GOOGL", b"Alphabet Inc", b"ZO Virtual Coin for Alphabet Inc (Google)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOGL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOOGL>>(v0);
    }

    // decompiled from Move bytecode v6
}

