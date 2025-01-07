module 0xefed5821c1133df964b439dde37829e578a139bc5cd6b025f52d03a6cfe26ad5::fredyeyes {
    struct FREDYEYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREDYEYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREDYEYES>(arg0, 6, b"FREDYEYES", b"FREDYEYES SUI", x"53657175656e636573206f662046726564792773206c6966652121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Su_V_Mni4aft4_X4oo_Qb_ZJ_Re_Sz_HMM_6c_Zj1kwc_QA_Lq_F2_A3d_R_429ed6c1b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREDYEYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREDYEYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

