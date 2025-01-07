module 0x9bc418511be4f358a50f3ffc7791e7c30ac240c9d0d79071f566a261a0e5d3af::WinterpineNeckwrap {
    struct WINTERPINENECKWRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTERPINENECKWRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTERPINENECKWRAP>(arg0, 0, b"COS", b"Winterpine Neckwrap", b"Stay close on the trail, lest you lose your way...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Winterpine_Neckwrap.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTERPINENECKWRAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTERPINENECKWRAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

