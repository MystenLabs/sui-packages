module 0x177800a922e6c6e7dae5197fceb992ebd2ee4d887706c1a2f5fa67b64b52e8f9::MeditativeGaze {
    struct MEDITATIVEGAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDITATIVEGAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDITATIVEGAZE>(arg0, 0, b"COS", b"Meditative Gaze", b"See their eyes? What becomes of them?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Meditative_Gaze.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEDITATIVEGAZE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDITATIVEGAZE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

