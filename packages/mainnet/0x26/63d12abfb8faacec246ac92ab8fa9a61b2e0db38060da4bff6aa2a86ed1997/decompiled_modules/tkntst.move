module 0x2663d12abfb8faacec246ac92ab8fa9a61b2e0db38060da4bff6aa2a86ed1997::tkntst {
    struct TKNTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNTST>(arg0, 6, b"TKNTST", b"Test Token AYU 1", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TKNTST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

