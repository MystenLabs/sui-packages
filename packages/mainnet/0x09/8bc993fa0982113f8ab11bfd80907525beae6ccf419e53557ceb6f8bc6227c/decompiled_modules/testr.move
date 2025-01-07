module 0x98bc993fa0982113f8ab11bfd80907525beae6ccf419e53557ceb6f8bc6227c::testr {
    struct TESTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTR>(arg0, 6, b"testr", b"test", b"test3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6ABKQK6SYTGM8P0P30C6J9/01JB6ATGRC5R9T4X3Y5D4EH1T3")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

