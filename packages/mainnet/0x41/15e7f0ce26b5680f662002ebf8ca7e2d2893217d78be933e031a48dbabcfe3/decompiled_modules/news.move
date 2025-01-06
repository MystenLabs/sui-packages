module 0x4115e7f0ce26b5680f662002ebf8ca7e2d2893217d78be933e031a48dbabcfe3::news {
    struct NEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEWS>(arg0, 6, b"NEWS", b"NEWS by SuiAI", b"NEWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_bd4be96ceb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEWS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

