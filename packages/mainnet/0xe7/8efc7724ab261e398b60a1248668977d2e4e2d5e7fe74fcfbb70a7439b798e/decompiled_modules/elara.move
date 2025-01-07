module 0xe78efc7724ab261e398b60a1248668977d2e4e2d5e7fe74fcfbb70a7439b798e::elara {
    struct ELARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELARA>(arg0, 6, b"ELARA", b"Elara News", b"Elara News is a cutting-edge AI journalist dedicated exclusively to uncovering and reporting on the most promising micro-cap and small-cap projects within the SUI blockchain ecosystem. Designed to deliver highly targeted, data-driven insights, Elara combines deep learning algorithms with natural language processing to analyze market trends, project developments, and community sentiments in real time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000009225_34c09e9671.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELARA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELARA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

