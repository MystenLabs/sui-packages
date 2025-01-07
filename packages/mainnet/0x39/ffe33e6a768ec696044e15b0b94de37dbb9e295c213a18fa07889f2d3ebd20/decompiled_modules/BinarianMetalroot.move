module 0x39ffe33e6a768ec696044e15b0b94de37dbb9e295c213a18fa07889f2d3ebd20::BinarianMetalroot {
    struct BINARIANMETALROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINARIANMETALROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINARIANMETALROOT>(arg0, 0, b"COS", b"Binarian Metalroot", b"Utility, rusted by the howl of this chasmed nook.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Binarian_Metalroot.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINARIANMETALROOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINARIANMETALROOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

