module 0x9a56a294fa601524ec0b8a66328c776d3304e7449d55aa05cb5c0254864725fc::BinarianNeckplate {
    struct BINARIANNECKPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINARIANNECKPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINARIANNECKPLATE>(arg0, 0, b"COS", b"Binarian Neckplate", b"What happened-what did you see-and where did they run?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Binarian_Neckplate.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINARIANNECKPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINARIANNECKPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

