module 0xa042359838c5e010832c785afd0ac6559f34b95f624ffd7b0e0e43740a53da8e::bgoat {
    struct BGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOAT>(arg0, 6, b"BGOAT", b"Baby", b"First Baby AI on SUI - Baby GOAT $BGOAT - CTO powered - Strong community $BGOAT will follow $GOAT IMHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pg1csghn5_Wg_Ub_KHM_83bc_A_Bi_X2_Xsf_Yja_Wyao_Z_Bo_L_Hs_Fp_U_781e594da4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

