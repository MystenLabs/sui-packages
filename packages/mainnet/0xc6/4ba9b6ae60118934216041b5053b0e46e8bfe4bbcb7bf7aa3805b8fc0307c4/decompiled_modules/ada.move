module 0xc64ba9b6ae60118934216041b5053b0e46e8bfe4bbcb7bf7aa3805b8fc0307c4::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Wrapped Cardano", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ADA>>(v0);
    }

    // decompiled from Move bytecode v6
}

