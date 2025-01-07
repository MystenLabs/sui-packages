module 0xfaaccc9dab4830511827ae68130d388a6cc30a6d548dacb6b74871ff0b0974b1::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"Grok", x"68692065766572796f6e652c206e69636520746f206d65657420796f750a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Pdo_Hciz_N5_CPMHWU_1n_PGN_Hg_Rzsukau_Yv_Y_Mv_A_Qb_EL_81_JT_45a192cfa2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

