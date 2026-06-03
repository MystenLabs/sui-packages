module 0xffdfc80ca813ab0a6a0a37e0fcd675e5be59298dfd7e741c407556d8bd3a463::day {
    struct DAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAY>(arg0, 6, b"DAY", b"SuiDay", x"f09f8c8520e2809c537461636b20646179732c206e6f7420726567726574732ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1780451833353.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

