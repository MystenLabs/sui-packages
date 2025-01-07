module 0xa4f38150463c1d4faa6408919ee6d87e207f1076b38a403cffa7a6473a2f75c::GraceoftheDepths {
    struct GRACEOFTHEDEPTHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEDEPTHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEDEPTHS>(arg0, 0, b"COS", b"Grace of the Depths", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Depths.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEDEPTHS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEDEPTHS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

