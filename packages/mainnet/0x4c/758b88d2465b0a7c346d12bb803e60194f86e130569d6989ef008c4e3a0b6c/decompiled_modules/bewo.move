module 0x4c758b88d2465b0a7c346d12bb803e60194f86e130569d6989ef008c4e3a0b6c::bewo {
    struct BEWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWO>(arg0, 6, b"BEWO", b"Blue Eyes White Omnicat", b"Bewo was used for experiments by Mysten Labs scientists, now he roams free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Zjkg_Mm_QB_Dz_Nq5_X_Ww_XR_2v_UER_2_Wx_Ce_B7_M_Vws_Ke_Z9_Ypump_f512652f58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

