module 0x88bd1b896dee51d7c6bdf06f3e4458277099af1486ee3f592d6a87a23aaa6992::spartan {
    struct SPARTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTAN>(arg0, 6, b"SPARTAN", b"SPARTAN", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

