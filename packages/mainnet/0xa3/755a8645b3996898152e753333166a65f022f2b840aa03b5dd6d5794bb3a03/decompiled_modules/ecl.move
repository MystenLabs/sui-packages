module 0xa3755a8645b3996898152e753333166a65f022f2b840aa03b5dd6d5794bb3a03::ecl {
    struct ECL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ECL>(arg0, 6, b"ECL", b"Ecliptica by SuiAI", b"Ecliptica is an AI-powered token driven by emotions and shadows. It embodies mysticism, manipulation, and intrigue, resonating with individuals seeking empowerment in complexity. Ecliptica connects users to an enigmatic realm where logic and insanity blur..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ECL_43125719c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ECL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

