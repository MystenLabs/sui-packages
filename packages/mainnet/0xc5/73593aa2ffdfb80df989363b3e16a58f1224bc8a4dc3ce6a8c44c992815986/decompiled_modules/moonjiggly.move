module 0xc573593aa2ffdfb80df989363b3e16a58f1224bc8a4dc3ce6a8c44c992815986::moonjiggly {
    struct MOONJIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONJIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONJIGGLY>(arg0, 9, b"JIGGLY", b"MoonJiggly", b"MoonJiggly token - a fun and jiggly asset on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.lighthouse.storage/ipfs/bafkreif5jj4h2xxpxmxsldj5ae3opl2sfwt77ie5vosxqmvzisqtkzjgsi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONJIGGLY>(&mut v2, 1000000000000000000, @0x4a05ec0f79b43dc0c15c19a0d30660c1e84028b841677651abd7e847ebb63c54, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONJIGGLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONJIGGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

