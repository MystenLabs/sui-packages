module 0xf18cd59099360e4d4acadfca0cde29823c58cd37f7dbb84626ffe55c9f418cb2::GraceoftheChasms {
    struct GRACEOFTHECHASMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHECHASMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHECHASMS>(arg0, 0, b"COS", b"Grace of the Chasms", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Chasms.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHECHASMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHECHASMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

