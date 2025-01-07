module 0x9dff14b531a5f32a25c441c21be50aec8fd623ce2cf2b0a633cbd77a6d6c3ca0::kill {
    struct KILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILL>(arg0, 6, b"KILL", b"Kill Zeros", b"Lets kill Zeros until we reach 1$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbjkath_V2_Ta2t_B9_AM_Ua_Mget_WKT_6_CZR_8_CF_1_KE_Uihn3b_Hn_L_387d3a5ebc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

