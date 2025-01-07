module 0xaa39966636aa0e4e4cd09284aad8c00ce2d96fba9ac2fb36dee99f10bf891a0d::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"Pepe", x"504550450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_PZ_5ybzhs_Rb_Y_Lw_W_Pf_S_Gz_YS_Wy_V_Yujr_Y_Gmgr_Xri_Ug6_Xr8_E_5263463b1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

