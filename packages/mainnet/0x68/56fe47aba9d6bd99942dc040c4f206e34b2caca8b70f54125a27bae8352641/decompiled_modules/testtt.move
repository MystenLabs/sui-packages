module 0x6856fe47aba9d6bd99942dc040c4f206e34b2caca8b70f54125a27bae8352641::testtt {
    struct TESTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTT>(arg0, 6, b"TESTTT", b"TEST", b"TESTTTTTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie46hzt7wmh4wgmtbn3h3o5kbv6ztfn43lqnx7wcrodojvvn3yxiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

