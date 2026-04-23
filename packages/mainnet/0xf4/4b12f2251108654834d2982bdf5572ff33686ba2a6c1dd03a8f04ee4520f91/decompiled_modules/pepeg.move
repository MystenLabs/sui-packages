module 0xf44b12f2251108654834d2982bdf5572ff33686ba2a6c1dd03a8f04ee4520f91::pepeg {
    struct PEPEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEG>(arg0, 6, b"PEPEG", b"PEPEG", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

