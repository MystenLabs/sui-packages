module 0xd8a35d275ab9cc88de689f2e4d7d7782617d13f74ff247ae03821e694fb4d6d5::ecl {
    struct ECL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ECL>(arg0, 6, b"ECL", b"Ecliptica", b"Ecliptica is an AI-powered token driven by emotions and shadows. It embodies mysticism, manipulation, and intrigue, resonating with individuals seeking empowerment in complexity. Ecliptica connects users to an enigmatic realm where logic and insanity blur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/01_14f9b0fbb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ECL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

