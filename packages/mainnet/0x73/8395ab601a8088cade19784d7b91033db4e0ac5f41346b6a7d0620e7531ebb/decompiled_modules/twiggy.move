module 0x738395ab601a8088cade19784d7b91033db4e0ac5f41346b6a7d0620e7531ebb::twiggy {
    struct TWIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIGGY>(arg0, 6, b"TWIGGY", b"Water Skiing Squirrel Twiggy", b"Twiggy, the legendary water-skiing squirrel, retired after 39 thrilling years! Now a crypto degen, his legacy continues through $TWIGGY on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Y8_Xu_Fs_Mq_M6_UT_Ueubek_YU_Tvv_Sm_X695_Zb1o_G5_Em_Dpump_8ee1970b49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

