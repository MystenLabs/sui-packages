module 0x5431bf37869dce8b2b91642e2b0f490c5bfc9b19d22b3a204b7833b6b162301::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"ai binary cat", b"ai binary cat($ABC)'s ready for an adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T2d_S6q_CL_3q_X6_G5i_MC_1v_N_Yr2_Wyt3_T_Et_K_Nqi9_D_Afnr_QX_49_c15d0e17a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

