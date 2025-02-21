module 0x69152cdf7f43e83379abe0a86293db4a689b690e3bb44d479151c282b6ec493e::yzy {
    struct YZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YZY>(arg0, 9, b"YzY", b"Yeezy Coin", b"DELETE MY TWITTER DELETE MY SHOPIFY IMMA BUY YOU MOTHERFUCKERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUKVKUbDBPQf5yua1Pn6uHeoRrZu7KU5rQdM1jR87ry3J")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YZY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YZY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

