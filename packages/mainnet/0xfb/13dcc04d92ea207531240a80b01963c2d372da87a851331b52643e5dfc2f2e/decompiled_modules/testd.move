module 0xfb13dcc04d92ea207531240a80b01963c2d372da87a851331b52643e5dfc2f2e::testd {
    struct TESTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTD>(arg0, 6, b"TESTD", b"Test", b"rwbvwwbr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3bvsqj5vxoxhhenlhja7k57vyiodzryvfthnfiikta7rqs4j63q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

