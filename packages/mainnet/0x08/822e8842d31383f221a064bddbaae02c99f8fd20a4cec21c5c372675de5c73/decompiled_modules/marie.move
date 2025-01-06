module 0x8822e8842d31383f221a064bddbaae02c99f8fd20a4cec21c5c372675de5c73::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 9, b"Marie", b"Marie Rose", b"The mascot behind SPX6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPGowbun9qZddcFtZaCHyD4Wi1mibiyhEDayNsdCmq5Lf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

