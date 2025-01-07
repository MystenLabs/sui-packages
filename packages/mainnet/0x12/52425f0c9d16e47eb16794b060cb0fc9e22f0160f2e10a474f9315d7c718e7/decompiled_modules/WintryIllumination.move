module 0x1252425f0c9d16e47eb16794b060cb0fc9e22f0160f2e10a474f9315d7c718e7::WintryIllumination {
    struct WINTRYILLUMINATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTRYILLUMINATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTRYILLUMINATION>(arg0, 0, b"COS", b"Wintry Illumination", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Wintry_Illumination.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTRYILLUMINATION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTRYILLUMINATION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

