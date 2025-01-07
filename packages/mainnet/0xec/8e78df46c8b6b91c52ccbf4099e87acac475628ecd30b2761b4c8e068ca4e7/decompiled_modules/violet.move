module 0xec8e78df46c8b6b91c52ccbf4099e87acac475628ecd30b2761b4c8e068ca4e7::violet {
    struct VIOLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIOLET>(arg0, 6, b"VIOLET", b"Dark Violet AI", b"Transform your learning journey with our AI-powered education platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Q3_Udo71v_Ph_J_Wybk_T_Yrgs4_V_Ryvqkni8y5t_D7_Yap_Wt_TDJ_7fb31a05ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIOLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

