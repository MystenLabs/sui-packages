module 0xc2e83ec732cb9b7499c0ec0f0bd2f4fbbc409793d1ed36625b3e797342447e43::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 9, b"PP", b"P3P3", b"PepeisAMemeSuiTOken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6f8jC1PMsVXcnaPhENM6jNrZa6uiLzhACsrJ1YdxNFyf.png?size=lg&key=ad7e6d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

