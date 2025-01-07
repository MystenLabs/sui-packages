module 0xd0340752bc174169ef01018b92a3047301774e638cb3f7def7144c04a3ceb27e::RABBIT {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 8, b"RABBIT", b"Sui Rabbit", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPi5CLqVuRZAGgxGjyW4XVyXH4LTYvK7TPbrYKvewtKY4?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RABBIT>>(0x2::coin::mint<RABBIT>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RABBIT>>(v2);
    }

    // decompiled from Move bytecode v6
}

