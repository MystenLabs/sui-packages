module 0xf5a158b42c2c4bd0703d1af3e02455799dd04c59ef72a1a2672d87b6fc0c4b03::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"Hello world", b"Hello World Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm3gzjlojq43vequ3if2uji25y3gjujqyl2coziruxwa4t2txw4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

