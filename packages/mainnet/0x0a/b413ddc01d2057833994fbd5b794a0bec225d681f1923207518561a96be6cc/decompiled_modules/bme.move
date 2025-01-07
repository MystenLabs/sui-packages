module 0xab413ddc01d2057833994fbd5b794a0bec225d681f1923207518561a96be6cc::bme {
    struct BME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BME>(arg0, 6, b"BME", b"Blue Move", b"we all one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_b8cc0bf624.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BME>>(v1);
    }

    // decompiled from Move bytecode v6
}

