module 0x2050c1321d649ba1838b6e27add459bc4bd4537f3860462e8c136579a64b3b8c::pixdoge {
    struct PIXDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXDOGE>(arg0, 6, b"PIXDOGE", b"PixDoge", x"5468652043757465737420506978656c20446f6765206f6e207468652053756920626c6f636b636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbam_XJ_Yah_Dh84_K3_WF_2q2_QGJ_Vvu1_WBMB_Dsh_J2_Mn7_A4vnc_Y_875baa6e95.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

