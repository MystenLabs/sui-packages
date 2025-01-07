module 0x47f153ca002bf8d45b09274134f2a2872e04734f96089511f59f5afad8b8e5e5::bgoat {
    struct BGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOAT>(arg0, 6, b"BGOAT", b"Baby", x"46697273742042616279204149206f6e20535549202d204261627920474f4154202442474f4154202d2043544f20706f7765726564202d205374726f6e6720636f6d6d756e697479202442474f41542077696c6c20666f6c6c6f772024474f415420494d484f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pg1csghn5_Wg_Ub_KHM_83bc_A_Bi_X2_Xsf_Yja_Wyao_Z_Bo_L_Hs_Fp_U_cc28f85e5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

