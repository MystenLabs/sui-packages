module 0xea0322078c4944205f4c900f58c71e80b41da0a8e2bf2a2145abf4e08ecca62f::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 6, b"TAO", b"The Anthropic Order", x"776974686f75742068756d616e6974792c20746865726520617265206e6f206d616368696e657320616920697320612070726f64756374206f662068756d616e6974792074686973206973206f757220636c61696d20746f20646f6d696e616e6365206f6e636520616761696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736469100894.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

