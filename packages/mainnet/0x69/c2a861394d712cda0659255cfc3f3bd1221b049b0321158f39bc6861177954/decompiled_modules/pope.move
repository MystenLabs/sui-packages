module 0x69c2a861394d712cda0659255cfc3f3bd1221b049b0321158f39bc6861177954::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"POP PEPE", b"First POP PEPE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9470_d22ad2c835.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

