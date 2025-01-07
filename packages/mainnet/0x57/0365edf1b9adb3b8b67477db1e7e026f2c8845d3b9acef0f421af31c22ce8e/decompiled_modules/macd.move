module 0x570365edf1b9adb3b8b67477db1e7e026f2c8845d3b9acef0f421af31c22ce8e::macd {
    struct MACD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACD>(arg0, 6, b"MACD", b"McDonald", b"Just put the fries in the bag lil bro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_123650291_1_1ef13717de.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACD>>(v1);
    }

    // decompiled from Move bytecode v6
}

