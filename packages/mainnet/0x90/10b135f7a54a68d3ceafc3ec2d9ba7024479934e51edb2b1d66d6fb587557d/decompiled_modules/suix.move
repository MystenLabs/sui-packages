module 0x9010b135f7a54a68d3ceafc3ec2d9ba7024479934e51edb2b1d66d6fb587557d::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"sui100 by SuiAI", b"First AI X agent on sui powered by DeepSeek-R1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui100_55da7573b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

