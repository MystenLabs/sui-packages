module 0x9ce2c6f2962e9db35e1ede3ca9893cda42ccc2b21bd398b2694da8c0f50a43c4::GraceoftheMists {
    struct GRACEOFTHEMISTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEMISTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEMISTS>(arg0, 0, b"COS", b"Grace of the Mists", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Mists.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEMISTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEMISTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

