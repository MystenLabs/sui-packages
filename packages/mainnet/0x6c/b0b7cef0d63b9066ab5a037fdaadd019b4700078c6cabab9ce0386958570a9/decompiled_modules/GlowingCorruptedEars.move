module 0x6cb0b7cef0d63b9066ab5a037fdaadd019b4700078c6cabab9ce0386958570a9::GlowingCorruptedEars {
    struct GLOWINGCORRUPTEDEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOWINGCORRUPTEDEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOWINGCORRUPTEDEARS>(arg0, 0, b"COS", b"Glowing Corrupted Ears", b"The sound of wings in the distance... the Vulture...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Glowing_Corrupted_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOWINGCORRUPTEDEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOWINGCORRUPTEDEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

