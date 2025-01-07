module 0x1ff0f378bde09fd58ef6310fd9bc22cb363094e138cd3aead2673a3fd404820b::iaius {
    struct IAIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IAIUS>(arg0, 6, b"IAIUS", b"iAiuS by SuiAI", b"iAiuS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Bx_K_Bda_Dr_Ci3fvz_P_Sv_Ks_Fc_VA_1_Ye_GFMY_Xo_Co6_KJV_1tpr_00f272844e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IAIUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAIUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

