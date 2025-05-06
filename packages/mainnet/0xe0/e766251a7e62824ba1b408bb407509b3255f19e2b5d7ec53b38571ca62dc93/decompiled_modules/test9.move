module 0xe0e766251a7e62824ba1b408bb407509b3255f19e2b5d7ec53b38571ca62dc93::test9 {
    struct TEST9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST9>(arg0, 6, b"TEST9", b"TEST TOKEN 9", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicmlypgfcstna4n6ykqxnhnouwnmurzyjhhhilnzbprknbjpurjmi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST9>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

