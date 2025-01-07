module 0x80b8efab4d442946a33de6e8dd0818d8426a422305de9f870937704dc361e83c::lowq {
    struct LOWQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOWQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOWQ>(arg0, 6, b"LOWQ", b"LOWQ ON SUI", b"Einstein? Never heard of her. But I know $LOWQ is an easy 100x  So dumb it can't fail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NU_7_J_Gt_Lyt_C_Zn_K8a5r19_No_Lmz_Hk_C_Djiqs4_Kim_FEWZ_Nz_Vg_d0845b1215.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOWQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOWQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

