module 0x5c738e80eb285a36f020b1bb86c7a4ab8237d36cfae61a49d29b3ac273ca394::seadoge {
    struct SEADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOGE>(arg0, 6, b"SeaDoge", b"SeaDoges", b"meme doge on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fe_Bg9_Utf5w_Fa2_Ps_T6_Kn_J6uitv_Wtfc87_R38wm_Rnxr_N_Mi_W_38b6bfc197.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

