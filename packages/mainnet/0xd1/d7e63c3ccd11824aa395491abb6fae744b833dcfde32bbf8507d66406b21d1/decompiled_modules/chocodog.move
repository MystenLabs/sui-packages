module 0xd1d7e63c3ccd11824aa395491abb6fae744b833dcfde32bbf8507d66406b21d1::chocodog {
    struct CHOCODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOCODOG>(arg0, 6, b"CHOCODOG", b"Agent Mocha", b"$ChocoDog is a playful and community-driven meme coin that combines the world of cryptocurrencies with the charm of dogs and chocolate. What sets $ChocoDog apart is its innovative integration with an AI-powered Twitter account.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733599453377.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOCODOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCODOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

