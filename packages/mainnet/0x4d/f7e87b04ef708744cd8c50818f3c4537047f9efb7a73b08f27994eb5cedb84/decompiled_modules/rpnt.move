module 0x4df7e87b04ef708744cd8c50818f3c4537047f9efb7a73b08f27994eb5cedb84::rpnt {
    struct RPNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPNT>(arg0, 9, b"RPNT", b"RANDOMPOINT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RPNT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

