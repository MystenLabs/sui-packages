module 0xf1761914840569ea4c8a81029d6c1e0ccd0c5c9266910abe35e67f99fd47723d::lesley {
    struct LESLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESLEY>(arg0, 6, b"LESLEY", b"LESLEY AI", b"LESLEY AI is an innovative artificial intelligence platform tailored for the cryptocurrency and blockchain space. It aims to empower users, traders, developers. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736898043191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESLEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESLEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

