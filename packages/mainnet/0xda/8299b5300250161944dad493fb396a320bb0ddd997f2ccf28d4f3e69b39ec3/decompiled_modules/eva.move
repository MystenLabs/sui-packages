module 0xda8299b5300250161944dad493fb396a320bb0ddd997f2ccf28d4f3e69b39ec3::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 6, b"EVA", b"EVA SUI", b"EVA SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pb_HQ_Px7g_K_Jw_Cu_Sg_X_Kpgb_Ly_Xges_DK_44_U7a1b4_Y5d_Vg_Cv_G_dda2ec9e57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

