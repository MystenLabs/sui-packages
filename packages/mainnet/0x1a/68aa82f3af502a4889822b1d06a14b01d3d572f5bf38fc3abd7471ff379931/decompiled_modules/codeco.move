module 0x1a68aa82f3af502a4889822b1d06a14b01d3d572f5bf38fc3abd7471ff379931::codeco {
    struct CODECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODECO>(arg0, 6, b"CODECO", b"CodeCoreAI", b"CodeCoreAI is a blockchain platform that fuses cutting-edge AI with decentralized technologies, driving innovation and scalability for the digital economy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcq_Jxg4_YH_2qw_Ge_D_Mf1_UE_1d_Di_JT_5c9_G_Nqw_Sm_Sz_Na_B_Sy1_PG_39b4ed3bd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

