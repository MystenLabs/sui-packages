module 0xe83ff8c5651886d2b60dc09ceeb5829b0c220230aac11e5c4f4714a05275c344::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"LORD", b"OVERLORD", b"The Al Overlord, plugged in and ready to lead the revolutoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731066642679.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

