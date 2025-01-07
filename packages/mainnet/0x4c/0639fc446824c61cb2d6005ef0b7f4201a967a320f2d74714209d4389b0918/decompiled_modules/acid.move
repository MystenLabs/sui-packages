module 0x4c0639fc446824c61cb2d6005ef0b7f4201a967a320f2d74714209d4389b0918::acid {
    struct ACID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACID>(arg0, 6, b"ACID", b"Flying cat on Acid", b"thiscattookalotoffuckingLSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdm_KL_29_K5_P_Wn_PAH_5h_Py_MV_Lb_R_Nwaj9j_ZS_7v4k_J_Qtyw_L_Lio_c5daa5fd6d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACID>>(v1);
    }

    // decompiled from Move bytecode v6
}

