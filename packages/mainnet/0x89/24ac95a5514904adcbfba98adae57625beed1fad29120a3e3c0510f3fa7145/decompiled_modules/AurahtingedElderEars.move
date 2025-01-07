module 0x8924ac95a5514904adcbfba98adae57625beed1fad29120a3e3c0510f3fa7145::AurahtingedElderEars {
    struct AURAHTINGEDELDEREARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHTINGEDELDEREARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHTINGEDELDEREARS>(arg0, 0, b"COS", b"Aurahtinged ElderEars", b"Wise one, listening between the trees... Listening, forever hearing...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Aurahtinged_ElderEars.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHTINGEDELDEREARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHTINGEDELDEREARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

