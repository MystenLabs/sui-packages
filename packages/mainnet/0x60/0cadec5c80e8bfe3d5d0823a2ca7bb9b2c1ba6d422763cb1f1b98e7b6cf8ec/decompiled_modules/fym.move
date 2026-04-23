module 0x600cadec5c80e8bfe3d5d0823a2ca7bb9b2c1ba6d422763cb1f1b98e7b6cf8ec::fym {
    struct FYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYM>(arg0, 6, b"FYM", b"FYM", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FYM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

