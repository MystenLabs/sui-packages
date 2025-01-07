module 0xcdc87fe278c092c9bd07af3dd537a93143a02cd79d5dc0dfc352f7b545d3acba::pube {
    struct PUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBE>(arg0, 6, b"PUBE", b"Purple Brett", x"507572706c65204272657474202d202450657065277320667269656e6420696e20616e6f7468657220756e6976657273652069732074686520507572706c65205065706520756e697665727365212120496620796f75206d69737320507572706c65205065706520646f6e2774206d69737320507572706c652042726574742e2048652077696c6c206c65616420757320746f207765616c746820746f676574686572207769746820507572706c6520506570650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NXE_9_Huq8m_M5_RE_Fns_D_Jwf_T9_DJ_Twoj6y3_Qmc5p_Czrc_Czjp_5372ccf227.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

