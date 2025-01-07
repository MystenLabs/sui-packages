module 0x4561d59f716b0c62f702ed459ce4ea5df90d36cef5b65fb10a842b2cad144aa1::tokenb {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENB>(arg0, 6, b"TOKENB", b"tokenb by SuiAI", b"tokenb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_087af4e472.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

