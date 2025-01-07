module 0x663e4150d80545243cd712ef128de05d74dc4397648a7f5a487c766904d8fad1::unicat {
    struct UNICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICAT>(arg0, 6, b"UNICAT", b"UNICAT SUI", b"Unlike other cat memecoins, UNICATis unique", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_X2_Kg_KNM_1he_Pj_K_Gf_Yi_Crt_X_Gk_Ue9p1k_Aj_H7_D_Egsn_S_Ek4j_acb45a0bdb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

