module 0xb98da6712a446b84708b9eb4d83346cd86a024836fbe0435431347bc60d88698::GraceoftheGroundlands {
    struct GRACEOFTHEGROUNDLANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEGROUNDLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEGROUNDLANDS>(arg0, 0, b"COS", b"Grace of the Groundlands", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Groundlands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEGROUNDLANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEGROUNDLANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

