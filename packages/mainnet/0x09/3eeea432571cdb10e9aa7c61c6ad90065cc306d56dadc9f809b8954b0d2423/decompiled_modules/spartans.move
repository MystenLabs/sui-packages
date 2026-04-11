module 0x93eeea432571cdb10e9aa7c61c6ad90065cc306d56dadc9f809b8954b0d2423::spartans {
    struct SPARTANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTANS>(arg0, 6, b"SPARTANS", b"SPARTANS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTANS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

