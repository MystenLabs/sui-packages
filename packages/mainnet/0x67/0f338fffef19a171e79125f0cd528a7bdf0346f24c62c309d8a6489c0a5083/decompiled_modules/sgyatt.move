module 0x670f338fffef19a171e79125f0cd528a7bdf0346f24c62c309d8a6489c0a5083::sgyatt {
    struct SGYATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGYATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGYATT>(arg0, 6, b"SGYATT", b"Santa GYATT", x"53616e74617320426f6f74790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Gz_M36ge_TSCF_9_Mwcg3p_LNL_Ew_A_Nvj_V_Bng_Sj_V7_Pvw_QAT_52_1f5e6acba6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGYATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGYATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

