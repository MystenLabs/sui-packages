module 0xd5ba149cc2ba9c319b70be09acb230d5e1b27fca15949b211a00d38dddba306e::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 6, b"SHARKY", b"SHARKY DOG", b"SHARKY DOG ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ze_KU_5yjb_Pczow_U4u_ZV_Tp_Cx_V_Lb_Xw_J8q_KWE_7s_M_Zw_G_Mzv_Dj_bc48bc9406.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

