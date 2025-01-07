module 0xcd8a0cfe583fb9b8bd8e11b2fb09fd2dae4e74b34495c33476aa87ebbed4f19::OutcastBowline {
    struct OUTCASTBOWLINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUTCASTBOWLINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUTCASTBOWLINE>(arg0, 0, b"COS", b"Outcast Bowline", b"Leave behind yourself and join our great someone else...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Outcast_Bowline.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OUTCASTBOWLINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUTCASTBOWLINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

