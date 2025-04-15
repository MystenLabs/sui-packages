module 0x8f396a5a5af7ecf8e8a760e26cf9eea62cea8bbb83688bc946528530df573a07::bonkers {
    struct BONKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKERS>(arg0, 6, b"Bonkers", b"Bonkers Meme Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONKERS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

