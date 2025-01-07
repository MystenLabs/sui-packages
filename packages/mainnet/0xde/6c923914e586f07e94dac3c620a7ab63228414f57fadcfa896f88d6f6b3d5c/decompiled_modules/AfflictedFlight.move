module 0xde6c923914e586f07e94dac3c620a7ab63228414f57fadcfa896f88d6f6b3d5c::AfflictedFlight {
    struct AFFLICTEDFLIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFFLICTEDFLIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFFLICTEDFLIGHT>(arg0, 0, b"COS", b"Afflicted Flight", b"Whatever it was... is now curdled by war...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Afflicted_Flight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFFLICTEDFLIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFFLICTEDFLIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

