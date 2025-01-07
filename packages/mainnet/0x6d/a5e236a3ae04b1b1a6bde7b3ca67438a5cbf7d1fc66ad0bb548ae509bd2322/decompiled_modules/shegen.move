module 0x6da5e236a3ae04b1b1a6bde7b3ca67438a5cbf7d1fc66ad0bb548ae509bd2322::shegen {
    struct SHEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEGEN>(arg0, 6, b"Shegen", b"SHEGEN", x"41697769746864616464796973737565730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Kg_AN_8n_LAU_74wjiy_Ki85m4_ZT_6_Z9_Mtqr_UT_Gfse8_Xapump_2662e80eaf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

