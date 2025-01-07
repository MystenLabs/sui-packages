module 0x3ca9220da9b0f0d9f5066d77d5f1b6609bdd20b31de9758b9c128c9a23cd4f72::sid {
    struct SID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SID>(arg0, 6, b"SID", b"SINDISS", b"SINDISS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zjib6_Df_My_Jp_Zwegpjyfio_X9893j_Ayn_Q_Cask_V2_Jcz_V_Ess_afc1f6ed05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SID>>(v1);
    }

    // decompiled from Move bytecode v6
}

