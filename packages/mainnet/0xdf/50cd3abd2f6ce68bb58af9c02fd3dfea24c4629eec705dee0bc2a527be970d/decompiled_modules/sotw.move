module 0xdf50cd3abd2f6ce68bb58af9c02fd3dfea24c4629eec705dee0bc2a527be970d::sotw {
    struct SOTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTW>(arg0, 6, b"SOTW", b"Scuba on the whale", b"The cutest scuba diving pooch has landed on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc2_TS_0i_XQAI_6_3o_9919b680c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

