module 0x18cf1190e41b499d47219f12e254e2161cd1971c3448c08ba11b55e4fa772dfd::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 8, b"TSLA", b"Tesla, Inc.", b"Sudo Virtual Coin for Tesla", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSLA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TSLA>>(v0);
    }

    // decompiled from Move bytecode v6
}

