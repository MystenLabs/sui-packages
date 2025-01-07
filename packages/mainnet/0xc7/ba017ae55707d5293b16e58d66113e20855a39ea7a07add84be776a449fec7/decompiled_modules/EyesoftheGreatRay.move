module 0xc7ba017ae55707d5293b16e58d66113e20855a39ea7a07add84be776a449fec7::EyesoftheGreatRay {
    struct EYESOFTHEGREATRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYESOFTHEGREATRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYESOFTHEGREATRAY>(arg0, 0, b"COS", b"Eyes of the Great Ray", b"Gaze not at that distant ocean among the stars; it is but a mirage...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Eyes_of_the_Great_Ray.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYESOFTHEGREATRAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYESOFTHEGREATRAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

