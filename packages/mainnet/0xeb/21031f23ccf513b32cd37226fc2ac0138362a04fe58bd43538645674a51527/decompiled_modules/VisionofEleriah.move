module 0xeb21031f23ccf513b32cd37226fc2ac0138362a04fe58bd43538645674a51527::VisionofEleriah {
    struct VISIONOFELERIAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISIONOFELERIAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISIONOFELERIAH>(arg0, 0, b"COS", b"Vision of Eleriah", b"A gaze through the tangled roots of history... to a moment when...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Vision_of_Eleriah.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISIONOFELERIAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISIONOFELERIAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

