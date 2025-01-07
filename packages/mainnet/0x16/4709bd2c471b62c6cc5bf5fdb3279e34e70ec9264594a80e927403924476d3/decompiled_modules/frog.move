module 0x164709bd2c471b62c6cc5bf5fdb3279e34e70ec9264594a80e927403924476d3::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"Frog", b"Frog by Claude", b"Frog by Claude ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Qa_Q_Vh_B_Kum_Y_Wq4_VUF_Mux1r_T6_Bj_QY_Krfp_A8yav_Hy5k_R_Ta_81db67831c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

