module 0x9399375766f3164a77dac441a1ba8124087e4945b86b1bb30717884fb740389a::hafuz {
    struct HAFUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAFUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAFUZ>(arg0, 6, b"HAFUZ", b"Hafuzliq AI", b"Onchain Cryptic Militant Cyber Movement Al Qaeda Enthusiasts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gv_TD_Lv_JA_43gbn_Hg_J_Vo_Vj_Tk_V_Qq_R_Tn_Y99i4_Kj_JA_1j_Spump_cda13673cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAFUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAFUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

