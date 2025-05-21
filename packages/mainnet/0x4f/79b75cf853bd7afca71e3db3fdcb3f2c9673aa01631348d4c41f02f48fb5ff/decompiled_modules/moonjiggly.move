module 0x4f79b75cf853bd7afca71e3db3fdcb3f2c9673aa01631348d4c41f02f48fb5ff::moonjiggly {
    struct MOONJIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONJIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONJIGGLY>(arg0, 9, b"JIGGLY", b"MoonJiggly", b"MoonJiggly token - a fun and jiggly asset on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.lighthouse.storage/ipfs/bafkreif5jj4h2xxpxmxsldj5ae3opl2sfwt77ie5vosxqmvzisqtkzjgsi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONJIGGLY>(&mut v2, 1000000000000000000, @0x3004d90dae38a1f9f6e9890aa7332c5679cc7ae59d69940a55fe8a27711937f3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONJIGGLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONJIGGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

