module 0xdabbd4594a20d3847968157acb57ad4271b01d6d50f63af13faa823739651df1::dippo {
    struct DIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIPPO>(arg0, 9, b"DIPPO", b"Dipped Hippo", b"Dipped Hippo: A unique token on the Sui blockchain designed for community engagement and utility. It leverages a playful theme to create a fun, approachable brand while focusing on scalability, affordability, and innovative use cases within the crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1478313291306967040/nGyBvDU5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIPPO>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

