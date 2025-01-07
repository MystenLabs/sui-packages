module 0x94cd0a8f59a1b3342117ac4c9ec79ab0cb2c65b0b62e8f39a1306ff81eef32b0::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"NEKO SUI", x"547261696c73206f6620677265656e20676c696d6d65722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ay_EUV_3_ZWK_Fibf_X_Cn_Cxar_Z_Qt83_J_Sgpxd_Am_Vu6qsf_Lpump_f3199b24ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

