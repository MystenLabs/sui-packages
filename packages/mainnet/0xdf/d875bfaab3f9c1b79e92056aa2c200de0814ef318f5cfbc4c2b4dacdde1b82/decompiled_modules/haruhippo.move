module 0xdfd875bfaab3f9c1b79e92056aa2c200de0814ef318f5cfbc4c2b4dacdde1b82::haruhippo {
    struct HARUHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARUHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARUHIPPO>(arg0, 6, b"HaruHippo", b"hippoharu", b"Hippo vs Miharu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zxv_O8_J_Xs_A_Mcy_Gb_9bd65f6a1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARUHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARUHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

