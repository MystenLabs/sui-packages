module 0xfd6a45b9249001c7ce5d0ac840d5207b20e3eff772dd2ebcd0fcc6bf935721ee::wait {
    struct WAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIT>(arg0, 6, b"WAIT", b"theydontloveyoulikeiloveyou", x"776169742e2e2e74686579646f6e746c6f7665796f756c696b65696c6f7665796f750a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbu_Md_B_Tt_BG_Auy_WY_Vm9m_ZFXN_Nozmy_Dtm_Smaai1_E1vr_U3_Yr_84f42f2672.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

