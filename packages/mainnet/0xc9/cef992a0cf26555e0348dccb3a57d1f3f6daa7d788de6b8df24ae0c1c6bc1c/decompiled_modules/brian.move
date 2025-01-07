module 0xc9cef992a0cf26555e0348dccb3a57d1f3f6daa7d788de6b8df24ae0c1c6bc1c::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 6, b"BRIAN", b"BRIAN GRIFFIN", b"Brian Griffin is a fictional character from the American animated sitcom Family Guy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_C52_A8_A0_0197_4899_BB_2_A_D3_D7_E177_D1_AC_5a3b8a3225.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

