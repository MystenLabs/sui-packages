module 0x322d65cfa9eef6bf06e2fbd6f29168a896e0e49aa65b4aae5c791a3c8320317c::tpor {
    struct TPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPOR>(arg0, 6, b"TPOR", b"Testing Portal", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TPOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

