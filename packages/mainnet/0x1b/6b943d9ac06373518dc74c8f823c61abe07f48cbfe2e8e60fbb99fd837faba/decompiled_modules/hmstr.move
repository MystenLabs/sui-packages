module 0x1b6b943d9ac06373518dc74c8f823c61abe07f48cbfe2e8e60fbb99fd837faba::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"HMSTR", b"SuiHamtaro", b"SUIHAMTARO is more than just a token, it represents a bold journey toward limitless possibilities. From the depths of ambition to the heights of success, HAMTARO inspires its community to dream big and aim higher. With every step, HAMTARO builds a story of growth, fun, and a united vision. Are you ready to join the adventure and make history with HAMTARO? Together, well swing to the top and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199298_d10bf1048a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

