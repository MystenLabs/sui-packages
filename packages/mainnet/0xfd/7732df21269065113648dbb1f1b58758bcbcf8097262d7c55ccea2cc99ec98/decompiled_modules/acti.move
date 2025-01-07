module 0xfd7732df21269065113648dbb1f1b58758bcbcf8097262d7c55ccea2cc99ec98::acti {
    struct ACTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACTI>(arg0, 6, b"ACTI", b"ACT I: The Pudgy", x"4143542049493a205448452050554447590a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZDT_Eo_T_Du8mz_CY_Sc_Au_XS_Dgo1_Qt_LCT_Sx_Rzvuo1_Fpk_U3_Eyd_968706e1cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

