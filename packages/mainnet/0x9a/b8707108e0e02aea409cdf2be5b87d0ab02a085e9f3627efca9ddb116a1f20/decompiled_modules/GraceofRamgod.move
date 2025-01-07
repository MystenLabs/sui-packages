module 0x9ab8707108e0e02aea409cdf2be5b87d0ab02a085e9f3627efca9ddb116a1f20::GraceofRamgod {
    struct GRACEOFRAMGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFRAMGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFRAMGOD>(arg0, 0, b"COS", b"Grace of Ramgod", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_Ramgod.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFRAMGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFRAMGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

