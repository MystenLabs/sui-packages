module 0xb1be487390f66ac04a74f0c9ea993eeb6dc0e44261ef73b7ddd236bcd1e19d14::rons {
    struct RONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONS>(arg0, 6, b"RONS", b"Rons Basement", b"Yo, $RONS is the new token from Boomer Ron's basement, where gold and silver are hyped up like a rock concert. $RONS is like this wild social experiment, following up on $UFD - Ron's \"unicorn fart dust.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uhq_V9_Nm_KM_9gqby13ag_K_Rpg_Ebef_Sz_V8_S4x_Xn_LL_5k_Dhz_Xu_cc7809ed25.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

