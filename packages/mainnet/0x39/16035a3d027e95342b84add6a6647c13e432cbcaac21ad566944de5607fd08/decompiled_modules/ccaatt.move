module 0x3916035a3d027e95342b84add6a6647c13e432cbcaac21ad566944de5607fd08::ccaatt {
    struct CCAATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAATT>(arg0, 6, b"CCAATT", b"Criminal Cat", b"MEOWWWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbwhn_Ly9_Bt2k7nyoixd4_J_Gjr_Kb_Fwc_RF_3_Uc_D_Si1wp_VZ_Fdr_3e4566c4aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCAATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

