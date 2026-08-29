module 0x1becd33451693e9f05a6d3e8e488e1063ed9d2017596412b492d948a5faf3d4c::testaa {
    struct TESTAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTAA>(arg0, 6, b"TESTAA", b"test aaa", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTAA>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTAA>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

