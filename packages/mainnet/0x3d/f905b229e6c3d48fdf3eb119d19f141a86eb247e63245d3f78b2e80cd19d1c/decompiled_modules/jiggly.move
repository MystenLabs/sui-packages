module 0x3df905b229e6c3d48fdf3eb119d19f141a86eb247e63245d3f78b2e80cd19d1c::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"MOONJIGGLY", b"Jiggly is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfw247hzy26odqfogyfk2twfva6bjrlcmfepwbq7p4fjj5kcq33e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

