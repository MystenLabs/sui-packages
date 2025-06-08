module 0xa74fa8134ff84884c406f9f1b7baddccbf70d9ccc15d51c9fbeaefc568dd7b8a::computer {
    struct COMPUTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMPUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPUTER>(arg0, 6, b"COMPUTER", b"Everything Computer", b"Everything is Computer #Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihohmi77kg37sb7u3a57qxy4k7okzk5jqn5ohztdxcgfcjvgxjoui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMPUTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COMPUTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

