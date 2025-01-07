module 0xf147a0a6940889c42cc9a6c58db682e3776cd23e188cfe997a66b7f4a21971db::mercury {
    struct MERCURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCURY>(arg0, 6, b"Mercury", b"Mercury Meme", x"4d65726375727920696e74726f2e0a49206c6f76652065786f706c616e6574732e20416e64206f7572206f776e20736f6c61722073797374656d20706c616e6574732e0a4d65726375727920697320696e20746865204d65726375727920636861696e2e20486572652069732061206772656174204d617273207673204d657263757279206578706572696d656e74206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Pngtreea_blue_glowing_water_star_ball_4737478_56100282d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

