module 0x6eff57b29a98f319c219222b44c3335102ef26e10aec4227f6e8c4316c99cf24::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL>(arg0, 6, b"SL", b"SUI Life", b"SL is the ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihidvbidl4glhyjz4ywfqlrdd3ygj7sxjbuh4mpudeiblwt46meuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

