module 0x9cf7403d64d65a4514ebca0eda6e943a6e409d8656d462714f0b0b8a3b9f8e3a::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 6, b"DAVE", b"DAVE SUI", x"6869206d79206e616d6520697320646176650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_G5_Ja_Lr_Y1qu6_XB_4_Tec_Sv_MN_8y_ACFC_7q_LM_3d_Hu_XL_Ru_Ho3_X_1df0cd1066.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

