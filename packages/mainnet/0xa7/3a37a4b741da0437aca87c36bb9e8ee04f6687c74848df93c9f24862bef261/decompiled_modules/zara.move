module 0xa73a37a4b741da0437aca87c36bb9e8ee04f6687c74848df93c9f24862bef261::zara {
    struct ZARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARA>(arg0, 6, b"Zara", b"ZaraZamanii", x"43454f200a406c75636b796b617473747564696f730a207c20436f2d466f756e6465722026204350544f200a4034706c757376656e74757265730a207c20436f2d466f756e646572200a40696f4e656f6b690a207c20426c6f636b636861696e207c2057656233207c2047616d696e67207c2046617368696f6e207c20436f4372656174696f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3055_3ed44ae950.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

