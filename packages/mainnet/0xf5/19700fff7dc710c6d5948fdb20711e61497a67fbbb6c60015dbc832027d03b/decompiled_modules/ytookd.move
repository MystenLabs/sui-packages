module 0xf519700fff7dc710c6d5948fdb20711e61497a67fbbb6c60015dbc832027d03b::ytookd {
    struct YTOOKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTOOKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTOOKD>(arg0, 6, b"Ytookd", b"YTook", b"dafasfsaef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOODENG_243b09800b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTOOKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YTOOKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

