module 0xa99ea42afc662bf4e15289358df7451cc062c054425a81b77a211c563d1ccd9c::tokenb {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENB>(arg0, 6, b"TOKENB", b"TOKENB by SuiAI", b"TOKENB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_dad91d8b09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

