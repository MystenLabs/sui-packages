module 0x2d6e4ffc6292ff00471c13113aa490a961a711eeb6e988a117f44f59c59271d3::suiclub {
    struct SUICLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICLUB>(arg0, 6, b"SUICLUB", b"Sui Club", b"Welcome to SUI Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V_Hhe_JBF_Sc_WSG_Yn9sb_LP_Pzn_G_Ry_MQ_1_Lnqt_Zq_Lfn_W3_WHMRH_584300b465.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

