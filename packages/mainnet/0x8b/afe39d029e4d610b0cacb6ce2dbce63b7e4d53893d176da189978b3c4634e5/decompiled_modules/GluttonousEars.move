module 0x8bafe39d029e4d610b0cacb6ce2dbce63b7e4d53893d176da189978b3c4634e5::GluttonousEars {
    struct GLUTTONOUSEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUTTONOUSEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUTTONOUSEARS>(arg0, 0, b"COS", b"Gluttonous Ears", b"Caught in the glare of darkness... light most deafening...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Gluttonous_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLUTTONOUSEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUTTONOUSEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

