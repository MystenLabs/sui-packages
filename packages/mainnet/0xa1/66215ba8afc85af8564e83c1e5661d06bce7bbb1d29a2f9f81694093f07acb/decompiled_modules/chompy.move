module 0xa166215ba8afc85af8564e83c1e5661d06bce7bbb1d29a2f9f81694093f07acb::chompy {
    struct CHOMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPY>(arg0, 6, b"CHOMPY", b"Chompy on SUI", x"63686f6d702063686f6d700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V51x5_Q7_WGXVGK_8_P_Yb_Mn_Dr_C6kys9nicp9_Symam_Aywk_PRR_9e5fd5ac1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

