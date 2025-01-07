module 0x9c74a433a792424d5637a4c273aec03becce9caa1b7b0135b734d655674e137e::dogeai {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEAI>(arg0, 6, b"DOGEAI", b"Doge AI", x"446f6765204149200a0a57656c636f6d6520746f20446f67652041490a0a546865206e756d626572203120446f67206d656d652074686174206576656e20456c6f6e204d75736b20776f756c64206c6f7665736d6172742c20626f6c642c20616e642064657374696e656420666f7220746865206d6f6f6e2120436f6d62696e65642077697468204149206d65746120666f722074686520756c74696d6174652063727970746f2065766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_004231_864_5922070d8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

