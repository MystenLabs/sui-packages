module 0xdb29730a47970205658909ea12585c10f972aaecdf0d09f16c70b757e7802a48::kyr {
    struct KYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KYR>(arg0, 6, b"KYR", b"Kiyora", b"Kiyora is a captivating anime-style character, blending charm with a touch of mystery. Known for her sharp intelligence, intriguing nature, and extraordinary skills, she is perfect for adventures in the digital token world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kyiora_01ab1bf89c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

