module 0xc83dd7f8510b03d094fffa9520f60f0ba634342abb85156ed12640012a127494::zenia {
    struct ZENIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENIA>(arg0, 6, b"ZENIA", b"Zenia AI", b"Zenia AI is the world's first Rust library that enables anyone to build a scalable, modular, and ergonomic LLM-powered application (It's launch to the public also marks day 1 of the LLM Revolution)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZTB_Skgv_PJ_7q4u3f3x_T_Nqsg_Cny_U_Mw_Ube_XT_Bm_XQER_Tjikp_24948838e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

