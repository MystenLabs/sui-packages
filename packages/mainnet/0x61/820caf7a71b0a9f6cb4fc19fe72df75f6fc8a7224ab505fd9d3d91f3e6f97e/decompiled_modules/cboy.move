module 0x61820caf7a71b0a9f6cb4fc19fe72df75f6fc8a7224ab505fd9d3d91f3e6f97e::cboy {
    struct CBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CBOY>(arg0, 6, b"CBOY", b"CHILL BOY  by SuiAI", b"CHILL BOY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_40d13fb89f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CBOY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

