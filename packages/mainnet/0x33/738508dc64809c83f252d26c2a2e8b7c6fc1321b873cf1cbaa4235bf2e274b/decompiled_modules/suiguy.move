module 0x33738508dc64809c83f252d26c2a2e8b7c6fc1321b873cf1cbaa4235bf2e274b::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SuiGUY", b"The Real Sui Guy", x"576520617265207265616c20616e642072656d656d6265722074686520747275746820616c7761797320636f6d6573206f75742e0a57656c636f6d6520746f20746865206e657720476f64206f6620537569204d656d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3jtj5l4d6inhj6ervjyqupl2n3btwy2grmfu2iqonycs3ok4pxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

