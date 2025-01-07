module 0x8ff5795e853492fcda4531fd0fa53e7dcddffa99aafe46f151b1715d37be939e::shar {
    struct SHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAR>(arg0, 9, b"SHAR", b"SHAR", x"57656c636f6d20747520626162692073686172206f6e2053756920736565617e20f09fa688202068747470733a2f2f742e6d652f73686172737569202068747470733a2f2f782e636f6d2f736861725f737569202068747470733a2f2f73686172736861722e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/sharsui/shar/refs/heads/main/sharlogo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

