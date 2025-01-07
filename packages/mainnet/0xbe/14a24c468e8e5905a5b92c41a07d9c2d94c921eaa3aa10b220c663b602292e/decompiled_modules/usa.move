module 0xbe14a24c468e8e5905a5b92c41a07d9c2d94c921eaa3aa10b220c663b602292e::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"AMERICAN COIN on Sui", b" RAAAAAAHHHH WHAT THE FUCK IS A KILOMETER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/69kd_R_Ly_P5_DT_Rkp_Hraa_SZA_Qb_Wm_Awz_F9gu_Kj_Zfz_M_Xzcb_As_43883167fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USA>>(v1);
    }

    // decompiled from Move bytecode v6
}

