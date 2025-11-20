module 0x65b0412f45ebdbf4316d952e71d2f550a71b9075abc563e1b75944a3490e6763::a_billion_coin {
    struct A_BILLION_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: A_BILLION_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_BILLION_COIN>(arg0, 6, b"ABC", b"A Billion Coin", b"A Billion Coin is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_BILLION_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_BILLION_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

