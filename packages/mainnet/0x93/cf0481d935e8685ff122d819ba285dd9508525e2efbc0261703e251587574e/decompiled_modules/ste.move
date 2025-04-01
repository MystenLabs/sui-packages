module 0x93cf0481d935e8685ff122d819ba285dd9508525e2efbc0261703e251587574e::ste {
    struct STE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STE>(arg0, 9, b"STE", b"suieth", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

