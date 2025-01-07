module 0xf5c47ed60437427be2fdfea8632e8def7a7208bffbef66ba87e0aaa9539d7535::bibitesai {
    struct BIBITESAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBITESAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBITESAI>(arg0, 6, b"BIBITESAI", b"The b1b1tes", x"5468652062316231746573202842494249544553204149290a5468697320697320546865204269626974657320412073696d756c6174696f6e20776865726520796f75206172652061626c6520746f2077617463682065766f6c7574696f6e2068617070656e206265666f726520796f75722076657279206579657321204561636820626962697465202874686520736d616c6c20637269747465727320796f7520736565206f6e207468652073637265656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NM_Migy_Pzpz_F_Yp_Yr_Ag42_UK_Bxpa_Et_Cv_Aw_BG_8_C_Bkhd_J_Qhq_W_1_048d8ab296.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBITESAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBITESAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

