module 0x8be1ecd3a5dcc72d2eb3de24b85f8be79c16bfb14f14172e869ff1ddac7a65b1::pokee {
    struct POKEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEE>(arg0, 6, b"POKEE", b"POKENOTBUY", b"DO NOT BUY THIS TOKEN, TESTING SNIPER BOTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibykekycry3b7ps5mgnkgjdev72gr7cossxdztlz43aqypgyjclve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

