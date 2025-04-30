module 0x3ed16350bce691b186296aee07775f8a1d6a8c68ef33a899cb72ebb462901651::r0r {
    struct R0R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R0R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R0R>(arg0, 6, b"R0R", b"R0AR TOKEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R0R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<R0R>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

