module 0x75eb68761ebede9b7b851016aa62801fb97b894974f31588a2d61392389ad101::s10x {
    struct S10X has drop {
        dummy_field: bool,
    }

    fun init(arg0: S10X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S10X>(arg0, 6, b"S10X", b"S10X", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S10X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S10X>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

