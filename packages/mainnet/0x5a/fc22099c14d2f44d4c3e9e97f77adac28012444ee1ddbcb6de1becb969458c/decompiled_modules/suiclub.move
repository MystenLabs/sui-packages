module 0x5afc22099c14d2f44d4c3e9e97f77adac28012444ee1ddbcb6de1becb969458c::suiclub {
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

