module 0xe69ca828162fcb01d757de3d1dbd2cd43e6c46a3533d14b8b3de1344efc52561::GraceoftheRiverway {
    struct GRACEOFTHERIVERWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHERIVERWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHERIVERWAY>(arg0, 0, b"COS", b"Grace of the Riverway", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Riverway.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHERIVERWAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHERIVERWAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

