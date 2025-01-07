module 0x1bc82fdd784eaf2d65b3b2fa39bf94d58ea2208047f428bb92d58c9c35d6405::susky {
    struct SUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSKY>(arg0, 6, b"SUSKY", b"Sui Husky", x"4c6f79616c20616e6420666173742c20245355534b592069732074686520666169746866756c20636f6d70616e696f6e206f662074686520537569204e6574776f726b2e2049747320726561647920746f2072756e207769746820746865207061636b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_mascot_logo_design_of_a_husky_with_sunglassescoin_ra_85b76b38_5c49_416d_9d39_8d3e0c496256_2_f7b8c86618.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

