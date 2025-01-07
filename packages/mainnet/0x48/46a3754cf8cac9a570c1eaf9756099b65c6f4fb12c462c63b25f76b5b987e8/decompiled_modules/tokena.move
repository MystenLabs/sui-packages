module 0x4846a3754cf8cac9a570c1eaf9756099b65c6f4fb12c462c63b25f76b5b987e8::tokena {
    struct TOKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENA>(arg0, 6, b"TOKENA", b"SUI DEV TOKENA by SuiAI", b"SUI DEV TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_f10ba19393.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

