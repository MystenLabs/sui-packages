module 0x79681867e7875247ab3cc8b3cadbddc9f570e691a0d81dd06276369b674fb56d::mwag {
    struct MWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAG>(arg0, 6, b"MWAG", b"MWAGNET", b"An unknown force, attracting degenerates, such as FWOGS, DWOGS, and all kinds to unite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zme_M69e_G_Uq8_FHC_Vos_E_Cm7_NKHE_Wx_EZXJ_3b5_HJ_3_BU_5e_He5_0b7084ff97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

