module 0xad5c34746a2e9dd93975aaee5a504e2ffcb456a5fcfe115c081129339d96e5e7::jeli {
    struct JELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELI>(arg0, 6, b"JELI", b"JELLI", b"just pixel game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jelli_logo_circle_860e5c9938.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELI>>(v1);
    }

    // decompiled from Move bytecode v6
}

