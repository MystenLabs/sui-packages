module 0xc32f8e549fdcd7de61901e692fa5b81f3d9cc55802cbacdf043071cc0792c270::gi {
    struct GI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GI>(arg0, 6, b"GI", b"GIS", b"GI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y5_Ac6_U_Kp_Zu_Z3pu4_B_Piuwif2my5_L_Mrj_Rb4_P_Zodi_Ym_Zx2_N_a6cdfba3c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GI>>(v1);
    }

    // decompiled from Move bytecode v6
}

