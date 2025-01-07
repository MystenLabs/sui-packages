module 0xdf513aff60d1fddafd0d84ce0fa978b5478278b776441e3519ae47ad3d6fed1a::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"NEW SUI TOKEN by SuiAI", b"NEW SUI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_379ee718a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

