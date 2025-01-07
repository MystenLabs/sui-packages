module 0xee72703656c0054779a73cbec0c1c8de0b7a44f03268b22894de4d6cdc52ef91::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"bullrun", b"bull run is right in the corner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VKCGBA_9_N_En_AH_6rnmmd9_A8_Tr2ux_Jyf3_G_Sr_Wjm_NNNTU_Hud_d4a266418c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

