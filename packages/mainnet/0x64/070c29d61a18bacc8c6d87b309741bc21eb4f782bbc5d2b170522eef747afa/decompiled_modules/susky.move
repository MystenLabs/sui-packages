module 0x64070c29d61a18bacc8c6d87b309741bc21eb4f782bbc5d2b170522eef747afa::susky {
    struct SUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSKY>(arg0, 6, b"SUSKY", b"Husky of Sui", x"5355534b592028546865204875736b79206f662053756929206973206865726520746f206c65616420746865207061636b206f6e2074686520537569204e6574776f726b2e2054686973206875736b79206973206c6f79616c2c206669657263652c20616e6420726561647920746f2072756e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_mascot_logo_design_of_a_husky_with_sunglassescoin_ra_85b76b38_5c49_416d_9d39_8d3e0c496256_2_a651b388d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

