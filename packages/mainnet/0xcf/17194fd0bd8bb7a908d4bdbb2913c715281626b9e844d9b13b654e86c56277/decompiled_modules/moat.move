module 0xcf17194fd0bd8bb7a908d4bdbb2913c715281626b9e844d9b13b654e86c56277::moat {
    struct MOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOAT>(arg0, 6, b"MOAT", b"Moat The Goat", b"Moat is a community-powered memecoin built on trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifrhnomoq5aciek4wo5ownv46qq4tk4qjqje2ljjtzuyhprxs5u7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

