module 0x29e7d2f0d8abe6dda2b77edf676622000b654bdff932925d38a1223685f4a1a8::sdfsd {
    struct SDFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSD>(arg0, 6, b"SDFSD", b"SDFSD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDFSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

