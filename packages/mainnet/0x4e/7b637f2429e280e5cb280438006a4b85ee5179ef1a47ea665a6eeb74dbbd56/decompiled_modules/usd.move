module 0x4e7b637f2429e280e5cb280438006a4b85ee5179ef1a47ea665a6eeb74dbbd56::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 8, b"USD", b"USD", b"this is usd", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

