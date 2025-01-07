module 0x1331d7da4e0c1e66b2f810e4d8197462f20746e62dfb7edb4d06a9a6b25df557::FormlessGlow {
    struct FORMLESSGLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORMLESSGLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORMLESSGLOW>(arg0, 0, b"COS", b"Formless Glow", b"Don't go... not yet... remember this place...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Formless_Glow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORMLESSGLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORMLESSGLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

