module 0x124b2f31b7adbcad99ffcfb5929d81c4bdd929bb8a201d2879bf4194db218d79::poptrix {
    struct POPTRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRIX>(arg0, 6, b"POPTRIX", b"PopTrix", b"POPCAT HAS ENTERED THE MATRIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pb22_CB_8_HN_1_Jcf_Z_Lrb_Wj_E_Sdiza_YU_Ac_Wv_H_Lb_AM_Csxtc6sw_83e4cef4b0_3bf7170889.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

