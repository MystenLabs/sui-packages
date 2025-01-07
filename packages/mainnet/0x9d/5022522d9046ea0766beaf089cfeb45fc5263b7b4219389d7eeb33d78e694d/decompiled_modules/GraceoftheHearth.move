module 0x9d5022522d9046ea0766beaf089cfeb45fc5263b7b4219389d7eeb33d78e694d::GraceoftheHearth {
    struct GRACEOFTHEHEARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEHEARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEHEARTH>(arg0, 0, b"COS", b"Grace of the Hearth", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Hearth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEHEARTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEHEARTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

