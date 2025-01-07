module 0xacbfb42b23fccfb735e9ebf85fc3d7aabc694104c5146e98ea9cab54e0591281::pov {
    struct POV has drop {
        dummy_field: bool,
    }

    fun init(arg0: POV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POV>(arg0, 6, b"POV", b"Pug On Vacation", b"enjoying sun and hot chicks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sfe_Gv4_Js5_Rf_CU_Ux_Yzk_Y_Mz3mv_RXC_Xouj9_L_Uq_YTMG_4zb7_X_8856a77ffb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POV>>(v1);
    }

    // decompiled from Move bytecode v6
}

