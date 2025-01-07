module 0xb834dc63c4e7fc76e82d830578d2b59d7e11bc3ed3efa943b8d81c6b5c506fa6::GraceofLegba {
    struct GRACEOFLEGBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFLEGBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFLEGBA>(arg0, 0, b"COS", b"Grace of Legba", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_Legba.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFLEGBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFLEGBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

