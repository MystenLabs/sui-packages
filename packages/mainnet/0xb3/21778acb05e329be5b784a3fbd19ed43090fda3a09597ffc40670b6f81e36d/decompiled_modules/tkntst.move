module 0xb321778acb05e329be5b784a3fbd19ed43090fda3a09597ffc40670b6f81e36d::tkntst {
    struct TKNTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNTST>(arg0, 6, b"TKNTST", b"Test Token AYU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TKNTST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

