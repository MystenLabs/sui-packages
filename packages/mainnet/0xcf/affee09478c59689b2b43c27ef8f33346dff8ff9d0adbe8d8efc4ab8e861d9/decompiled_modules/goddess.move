module 0xcfaffee09478c59689b2b43c27ef8f33346dff8ff9d0adbe8d8efc4ab8e861d9::goddess {
    struct GODDESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDESS>(arg0, 6, b"goddess", b"Goddess", b"I bring you fortune by busting on my photos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBKG7QA987KP3W1K106AB7VM/01JBKH8V4AYBVGTMNE926H7HA4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODDESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

