module 0xfb163720bf45e6ae3d71880ae22a1f98fd6b0d0f9e432130be4845bc3ac707ca::teejmax {
    struct TEEJMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEJMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEJMAX>(arg0, 6, b"TeeJMax", b"TeeJMaximus", x"235465654a4d6178207c204f47207c20646f6573206e6f742070616e69632073656c6c2c2068652070616e696320627579732041492f4d656d65202363727970746f2077617272696f722c20726561647920746f206669676874207468726f7567682074686520237472656e6368657320616e6420436f6e717565722074686520234a656574732028205465654a20290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Vt_Hof_QB_Qt_D1w_C_Ei_Gx_Edwon_M_Dist_Dzq8po_Yoa_Hj_Vxcai_40a916c265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEJMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEEJMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

