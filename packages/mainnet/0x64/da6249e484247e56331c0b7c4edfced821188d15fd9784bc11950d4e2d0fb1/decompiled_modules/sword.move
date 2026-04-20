module 0x64da6249e484247e56331c0b7c4edfced821188d15fd9784bc11950d4e2d0fb1::sword {
    struct SWORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORD>(arg0, 6, b"SWORD", b"SWORD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

