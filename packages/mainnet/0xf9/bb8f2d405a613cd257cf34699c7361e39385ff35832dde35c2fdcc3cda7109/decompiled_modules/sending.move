module 0xf9bb8f2d405a613cd257cf34699c7361e39385ff35832dde35c2fdcc3cda7109::sending {
    struct SENDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDING>(arg0, 6, b"Sending", b"it's sending", b"It's sending", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_JS_Cj4m65xc_Q2pf1i48_Qb_QT_So2a_Ec_G_Rz_W_Td_Pj3_E4srn_Z_4329f218e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDING>>(v1);
    }

    // decompiled from Move bytecode v6
}

