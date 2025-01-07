module 0x673b7519d9b8a09621215a3af7b11c5a5ac40c87e81ebe8bbebf078b920a21ac::GraceoftheTemples {
    struct GRACEOFTHETEMPLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHETEMPLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHETEMPLES>(arg0, 0, b"COS", b"Grace of the Temples", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Temples.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHETEMPLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHETEMPLES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

