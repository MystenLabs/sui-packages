module 0xca5f912b733dc2ba87e6eb7266299400197a8d75292328f2611986ae3f02cf34::GraceoftheEnclave {
    struct GRACEOFTHEENCLAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEENCLAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEENCLAVE>(arg0, 0, b"COS", b"Grace of the Enclave", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Enclave.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEENCLAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEENCLAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

