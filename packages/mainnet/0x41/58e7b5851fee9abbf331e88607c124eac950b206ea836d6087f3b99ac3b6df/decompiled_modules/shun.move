module 0x4158e7b5851fee9abbf331e88607c124eac950b206ea836d6087f3b99ac3b6df::shun {
    struct SHUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUN>(arg0, 6, b"SHUN", b"SHUNSUKE", b"Shunsuke aka The Cutest Dog In The World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rs_ZUG_4_HF_5k_Vu_W_Vi6h_R_Ye6u_Cok_Jm_YS_5a7e_K_Xzq_TH_Ju_B_Ay_43d5a66cf7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

