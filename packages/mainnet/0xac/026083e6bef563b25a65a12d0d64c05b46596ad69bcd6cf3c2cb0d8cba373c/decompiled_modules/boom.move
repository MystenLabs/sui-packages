module 0xac026083e6bef563b25a65a12d0d64c05b46596ad69bcd6cf3c2cb0d8cba373c::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"This is how we do it", x"5765206d616b652063686172747320676f20626f6f6d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W2q_S6_W_Hj_P_Vprk_Ft8t_Q78u_Av3_S6fxbk_Mb_FN_Mgx_RX_5_B_Dod_3e4f9ae841.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

