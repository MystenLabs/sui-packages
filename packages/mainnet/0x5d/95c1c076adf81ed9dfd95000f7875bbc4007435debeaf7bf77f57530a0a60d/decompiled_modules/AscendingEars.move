module 0x5d95c1c076adf81ed9dfd95000f7875bbc4007435debeaf7bf77f57530a0a60d::AscendingEars {
    struct ASCENDINGEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCENDINGEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCENDINGEARS>(arg0, 0, b"COS", b"Ascending Ears", b"Oh, where did you come from? No matter: You're here now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ascending_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASCENDINGEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCENDINGEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

