module 0xae082f51555594c67d4cd999aeb69791b31233a2b3489128a66cd8542e10ec7d::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"CHILL BOY by SuiAI", b"CHILL BOY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_4300eeeff5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

