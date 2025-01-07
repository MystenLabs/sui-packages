module 0xaeac7d345b2ca469d734bd503d569c51931e6d9c36e4575194ebe177164f5638::GraceofNindfall {
    struct GRACEOFNINDFALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFNINDFALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFNINDFALL>(arg0, 0, b"COS", b"Grace of Nindfall", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_Nindfall.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFNINDFALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFNINDFALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

