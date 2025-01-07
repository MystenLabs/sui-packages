module 0x16f6e89498008e8fc4d01814a16031c2d5d0bf8733dc222a3c9356bd61ee950d::shawty {
    struct SHAWTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWTY>(arg0, 6, b"SHAWTY", b"damn shawty", x"64616d6e207368617774790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QM_6vqc_F7jfg_Jy_Bg8c17_Q4y_Dd_X5_JQ_Bb_Nqre_R_Pfr_KRU_6_AH_226053343c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

