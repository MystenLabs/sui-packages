module 0x266a1d6e3033c42925b6836c21a686a48792373acd02fc89497dff83210a07f7::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"ALPHA", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

