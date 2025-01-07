module 0xefae2478789e76d1356850b3b521cc631e2ea1388093916bbda03d6495b9e3f1::FireSeekerEyes {
    struct FIRESEEKEREYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRESEEKEREYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRESEEKEREYES>(arg0, 0, b"COS", b"FireSeeker Eyes", b"See through the inferno... Not angry, but confused...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_FireSeeker_Eyes.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRESEEKEREYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRESEEKEREYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

