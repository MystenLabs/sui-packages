module 0x9f134e5bb9fdd6afb9a0953861f6a7e5cf7fb4d438b9769b600792a24967b2d8::GoldenGlowgrowth {
    struct GOLDENGLOWGROWTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENGLOWGROWTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENGLOWGROWTH>(arg0, 0, b"COS", b"Golden Glowgrowth", b"Begging not for attention, but total ignorance... begging still...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Golden_Glowgrowth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDENGLOWGROWTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENGLOWGROWTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

