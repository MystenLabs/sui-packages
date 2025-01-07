module 0x5da27d214f05db0dd838f1ab4841eb77999ded1170713f03fb6dbd1479dc6ae5::odung {
    struct ODUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODUNG>(arg0, 6, b"ODUNG", b"ODUNG SUI", b"First-of-its-kind Korean Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Xha_Eim_A49_Rqyux_X9_W3_Lau_Nnz2e3z6o8_D_Wv_Ex_Vr6_G_Ugb_2fde896f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

