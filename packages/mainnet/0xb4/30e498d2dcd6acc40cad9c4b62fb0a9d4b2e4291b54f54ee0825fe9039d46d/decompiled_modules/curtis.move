module 0xb430e498d2dcd6acc40cad9c4b62fb0a9d4b2e4291b54f54ee0825fe9039d46d::curtis {
    struct CURTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURTIS>(arg0, 6, b"CURTIS", b"curtis", x"63757274697320676f696e67206e7574730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ngb_C_Hx_Aub_P1_Ex_U_Vp_F15w6py16_Ucv_Mfb_GZ_Vgh_Whzz5_TVN_0ca2cad473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CURTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

