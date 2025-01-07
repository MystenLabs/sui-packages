module 0x5421e121ed7225787af10d7c8e185d1641ca4a026e4c1a62c6962ae6897d8f51::goddess {
    struct GODDESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDESS>(arg0, 6, b"GODDESS", b"SUIGODDESS", b"I BRING YOU FORTUNE BY BUSTING ON MY PHOTOS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBKG7QA987KP3W1K106AB7VM/01JBKHC8J37P6637ZZZ4EBZ2ET")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODDESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

