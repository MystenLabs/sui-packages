module 0xc8867d67e89515964e400ae10c9bdaeadea32813dbc7fc457836eb04234f5566::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 6, b"RICH", b"Rich", b"Rich is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

