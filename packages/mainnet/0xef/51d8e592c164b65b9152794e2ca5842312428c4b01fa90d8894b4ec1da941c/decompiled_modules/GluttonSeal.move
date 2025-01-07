module 0xef51d8e592c164b65b9152794e2ca5842312428c4b01fa90d8894b4ec1da941c::GluttonSeal {
    struct GLUTTONSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUTTONSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUTTONSEAL>(arg0, 0, b"COS", b"Glutton Seal", b"Locked away... buried underneath... kept within...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Glutton_Seal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLUTTONSEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUTTONSEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

