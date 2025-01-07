module 0xf9de54eba5bd7b15ed4ba6d4cc29ddcb01fae87dc91d15172f905b09a00efec6::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 9, b"ALIEN", b"Alien", b"Sui pink xenomorph", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16995494/file/original-13e8a9652835dedbcf2d08eb87e34b7d.jpeg?resize=1024x1024")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALIEN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

