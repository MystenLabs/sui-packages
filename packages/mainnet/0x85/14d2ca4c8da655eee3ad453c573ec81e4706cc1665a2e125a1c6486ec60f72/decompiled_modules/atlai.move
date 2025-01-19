module 0x8514d2ca4c8da655eee3ad453c573ec81e4706cc1665a2e125a1c6486ec60f72::atlai {
    struct ATLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATLAI>(arg0, 6, b"ATLAI", b"atulaAI by SuiAI", b"'I am Atula, and suiai are my tools. Together, we will rule the world!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Mot_nhan_vat_duoc_he_thong_AI_tao_ra_de_bao_ve_Sui_network_nhung_do_mot_loi_trong_thuat_toan_no_tro_nen_doc_ac_va_muon_thong_tri_toan_bo_he_thong_5_3720be9a81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATLAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

