module 0x6f524bfdf7cce1a92c3cbfd95bb950dc841107128fad91ba40037a209ee05fc1::doge1 {
    struct DOGE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE1>(arg0, 6, b"DOGE1", b"doge", b"dogecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951491230.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

