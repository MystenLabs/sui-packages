module 0xc011b2f59f84c545729390e98124e9727c1ccdaf99b7ed3e5eef14aa7582a2d9::pixshiba {
    struct PIXSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXSHIBA>(arg0, 6, b"PIXSHIBA", b"Pixel Shiba", b"PIXSHIBA combines the playful spirit of Shiba Inu with pixel art fun on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_a_shiba_inu_with_sunglassespixelart16_bitfull_bodyfr_0dd34b7e_5316_461f_ac4b_26e4a55e0816_1_8c69d9c5e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

