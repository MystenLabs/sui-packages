module 0x1e5d382dac823a6d95e5ff1e1f9f06a811d2f709f42f6120745b03cade505779::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"Wolf", b"Sui LandWolf", b"LandWolf is the most Degenerate character from the Matt Furie's Boy's club comic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_C597_AC_0_3_A34_41_BB_B2_BB_85_AF_50_CD_5291_06cae72981.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

