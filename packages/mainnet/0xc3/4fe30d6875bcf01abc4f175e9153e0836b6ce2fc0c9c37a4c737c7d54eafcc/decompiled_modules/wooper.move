module 0xc34fe30d6875bcf01abc4f175e9153e0836b6ce2fc0c9c37a4c737c7d54eafcc::wooper {
    struct WOOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOPER>(arg0, 6, b"Wooper", b"Suiper Wooper", b"Hop in with the WOOPER and lets grow together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3gwzui3cys7eiqfjv4d6pws4ywihtqfeog6f6mokekyirectinm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

