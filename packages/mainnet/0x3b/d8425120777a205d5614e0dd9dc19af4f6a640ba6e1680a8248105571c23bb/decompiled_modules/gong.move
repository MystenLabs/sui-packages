module 0x3bd8425120777a205d5614e0dd9dc19af4f6a640ba6e1680a8248105571c23bb::gong {
    struct GONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONG>(arg0, 6, b"GONG", b"GONG", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GONG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

