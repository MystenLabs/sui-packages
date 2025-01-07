module 0xca51538cd68429da94ba971137541b970af9fe575d5d38f68b33a8cd83880019::deg {
    struct DEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEG>(arg0, 6, b"DEG", b"DEVDOG", b"COOKED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_WQ_Wc8_DDPXJ_Rc_Yn6_Y7_P_Dti_Jua_Xunjs_DY_963_Yb7_Ns44_HX_7f35b027d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

