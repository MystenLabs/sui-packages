module 0xe444814a61ccee85aa82f96145ce855f7f2121c7ce57b9475cabcba23f313977::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"TESTT", b"test", b"TestTokenDoNotBuyD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

