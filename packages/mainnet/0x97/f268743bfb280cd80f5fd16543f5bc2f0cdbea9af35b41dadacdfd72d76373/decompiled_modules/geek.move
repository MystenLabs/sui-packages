module 0x97f268743bfb280cd80f5fd16543f5bc2f0cdbea9af35b41dadacdfd72d76373::geek {
    struct GEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEEK>(arg0, 6, b"GEEK", b"GEEK of Sui", b"Just geeking on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibgq3tqjxem3pl2jrjzmf3evdh2datlpwjkvnknog4jfrw64qvope")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

