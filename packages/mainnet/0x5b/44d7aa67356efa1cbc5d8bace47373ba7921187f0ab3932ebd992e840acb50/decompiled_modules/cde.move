module 0x5b44d7aa67356efa1cbc5d8bace47373ba7921187f0ab3932ebd992e840acb50::cde {
    struct CDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDE>(arg0, 6, b"CDE", b"CRAWDADDYEMPIRE", x"4669727374206f6620697473206b696e642e204c6f75697369616e61206372617766697368206d656d6520636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RCCQBD_Fa8_Sx8_J_Tu_Pj_F_Puu_ER_Ap_Pib_TN_4_Acxjjntjm_Z_Yb_X_4c5603575e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

