module 0x481f37f7e123b1181ce6b29400e4da9dccbe7bb36152eed2f111be02eef59414::analsex {
    struct ANALSEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANALSEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANALSEX>(arg0, 6, b"AnalSex", b"Anal Sex Live", b"https://twitchs.cam/AnalSex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihtca5jxmdqqfjb2zpco3jj7pprthxowts5uyoq35lhhrdylelmiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANALSEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANALSEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

