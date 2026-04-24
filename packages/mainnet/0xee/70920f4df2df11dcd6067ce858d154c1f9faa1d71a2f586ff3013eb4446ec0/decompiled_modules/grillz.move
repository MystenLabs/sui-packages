module 0xee70920f4df2df11dcd6067ce858d154c1f9faa1d71a2f586ff3013eb4446ec0::grillz {
    struct GRILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRILLZ>(arg0, 6, b"GRILLZ", b"GRILLZ", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRILLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

