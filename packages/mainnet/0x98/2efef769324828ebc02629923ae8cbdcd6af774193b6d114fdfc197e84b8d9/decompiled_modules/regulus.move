module 0x982efef769324828ebc02629923ae8cbdcd6af774193b6d114fdfc197e84b8d9::regulus {
    struct REGULUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGULUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGULUS>(arg0, 6, b"Regulus", b"Regulus Maximus", b"Regulus Regulus Maximus ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qd9rh_LK_Rz_Xdrku_K2_Nc3w5_E_Eb_Z3_Vh_Yg_Zj_Nx_Ajm_BL_Nx47j_5fff2c0030.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REGULUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

